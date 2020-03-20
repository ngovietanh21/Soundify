//
//  PlaylistDetailViewController.swift
//  Soundify
//
//  Created by Viet Anh on 3/15/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit
import Reusable

final class PlaylistDetailViewController: BaseDetailViewController {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var ownerImageView: UIImageView!
    @IBOutlet private weak var ownerNameLabel: UILabel!
    @IBOutlet private weak var descriptionsLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    @IBOutlet private weak var numberLikeLabel: UILabel!
    
    //MARK: - Detail View
    private lazy var detailView = TopDetailView(frame:
                                        CGRect(x: 0, y: 0,width: view.frame.width, height: 0), with: playlist)
    
    //MARK: - Variable for Table View
    private var total = 0
    private var limit = 100
    private var offset = 0
    
    var playlist: Playlist!
    
    private var totalTimeTrack = 0 {
        didSet {
            DispatchQueue.main.async {
                self.timeLabel.text = "\(self.playlist.tracks.total) songs • " +  self.totalTimeTrack.msToSeconds.formatterFullTimes
            }
        }
    }
    
    private var items: [PlaylistDetailTrack] = [] {
        didSet {
            totalTimeTrack = items.reduce(0) { $0 + $1.track.durationMs }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        fetchData()
    }
    
    private func configView() {
        configDetailView()
        configTableView()
    }
    
    private func configDetailView() {
        view.addSubview(detailView)
        ownerImageView.makeRounded()
        detailView.delegate = self
        descriptionsLabel.text = playlist.description
    }
    
    private func configTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = detailView.edgeInsets
    }
}

//MARK: - TopDetailViewDelegate
extension PlaylistDetailViewController: TopDetailViewDelegate {
    
    func leftBarButtonItemClicked() {
        navigationController?.popViewController(animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView){
        detailView.scrollViewDidScroll(scrollView)
    }
}

//MARK: - UserRepository
extension PlaylistDetailViewController {
    
    private func fetchData() {
        fetchUsersProfile(user: playlist.owner)
        fetchPlaylistDetail(playlist: playlist)
        fetchPlaylistDetailTrack()
    }
    
    private func fetchPlaylistDetail(playlist: Playlist) {
        total = playlist.tracks.total
        UserRepository.shared.getPlaylistDetail(playlist: playlist) { [weak self] result in
            switch result {
            case .success(let result):
                if let playlistDetail = result {
                    DispatchQueue.main.async {
                        self?.numberLikeLabel.text = "\(playlistDetail.followers.total.commaSeparator) likes"
                    }
                }
            case .failure(let error):
                self?.showErrorAlert(message: error.debugDescription)
            default:
                break
            }
        }
    }
    
    private func fetchPlaylistDetailTrack() {
        UserRepository.shared.getPlaylistDetailTrack(limit: limit, offset: offset, playlist: playlist){
            [weak self] result in
            switch result {
            case .success(let result):
                if let tracks = result?.items {
                    self?.items += tracks
                }
            case .failure(let error):
                self?.showErrorAlert(message: error.debugDescription)
            default:
                break
            }
        }
    }
    
    private func fetchUsersProfile(user: User) {
        UserRepository.shared.getUsersProfile(user: user) { [weak self] result in
            switch result {
            case .success(let result):
                if let userDetail = result {
                    DispatchQueue.main.async {
                        self?.ownerNameLabel.text = userDetail.displayName
                        self?.ownerImageView.sd_setImage(with: URL(string: userDetail.images.first?.url ?? ""), completed: nil)
                    }
                }
            case .failure(let error):
                self?.showErrorAlert(message: error.debugDescription)
            default:
                break
            }
        }
    }
    
}

//MARK: - UITableViewDataSource
extension PlaylistDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: TrackPlaylistDetailTableViewCell.self)
        cell.configCell(track: items[indexPath.row].track)
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension PlaylistDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let track = items[indexPath.row].track
        let trackDetailViewController = TrackDetailViewController()
        trackDetailViewController.track = track
        trackDetailViewController.modalPresentationStyle = .overFullScreen
        present(trackDetailViewController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.TableView.heightForRowTrackPlaylistDetail
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.items.count - 1 {
            loadMore()
        }
    }
    
    private func loadMore() {
        if offset + limit <= total {
            offset += limit
            fetchPlaylistDetailTrack()
        } else if offset != total {
            offset = total
            fetchPlaylistDetailTrack()
        }
    }
}
