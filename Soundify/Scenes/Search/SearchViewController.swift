//
//  SearchViewController.swift
//  Soundify
//
//  Created by Viet Anh on 2/29/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit
import Reusable

final class SearchViewController: BaseViewController {
    
    private var total = 0
    private var limit = 20
    private var offset = 0
    private var items: [Any] = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    private let itemsSegmented = ["Tracks", "Artists", "Albums", "Playlists"]
    
    @IBOutlet private  weak var tableView: UITableView!
    private lazy var segmentedControl = SearchSegmentedControl(items: itemsSegmented)
    private lazy var searchController = UISearchController()
    private lazy var buttonBar = ButtonBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        configView()
    }
    
    override func viewWillLayoutSubviews() {
        DispatchQueue.main.async { [weak self] in
            self?.updataPositionButtonBar()
        }
    }
    
    private func fetchDataSearchForAnItem(query: String, type: String) {
        UserRepository.shared.searchForAnItem(query: query, type: type, limit: limit, offset: offset) {
            [weak self] result in
            switch result {
            case .success(let data):
                if let data = data {
                    self?.updateItems(data: data)
                }
            case .failure(let error):
                self?.showErrorAlert(message: error.debugDescription)
            default:
                break
            }
        }
    }
}

//MARK: - Dismiss Keyboard
extension SearchViewController {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchController.searchBar.endEditing(true)
    }
}

//MARK: - Items
extension SearchViewController {
    
    private func resetItemWhenChangeValue() {
        items = []
        total = 0
        offset = 0
    }
    
    private func searchAnItem(text: String?) {
        if let text = text {
            let type = itemsSegmented[segmentedControl.selectedSegmentIndex].encodeForSearch
            fetchDataSearchForAnItem(query: text, type: type)
        }
    }
    
    private func updateItems(data: SpotifySearch) {
        if let tracks = data.tracks {
            total = tracks.total
            items += tracks.items
        }
        
        if let artists = data.artists {
            total = artists.total
            items += artists.items
        }
        
        if let albums = data.albums {
            total = albums.total
            items += albums.items
        }
        
        if let playlists = data.playlists {
            total = playlists.total
            items += playlists.items
        }
    }
}

//MARK: - SetUpView and ConfigView
extension SearchViewController {
    
    private func configView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: ResultSearchCell.self)
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
    }
    
    private func setUpView() {
        setUpSearchBarViewController()
        
        view.addSubview(segmentedControl)
        segmentedControl.setUpView()
        segmentedControl.setUpConstraints(on: self)
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged(_:)),  for: .valueChanged)
        
        view.addSubview(buttonBar)
        buttonBar.setUpConstraints(on: self, hasSegmentedControl: segmentedControl)
    }
    
    private func setUpSearchBarViewController() {
        let appearance = UINavigationBarAppearance()
        
        let attributedString: [NSAttributedString.Key: Any] =
            [.foregroundColor : UIColor.white]
        
        appearance.titleTextAttributes = attributedString
        appearance.backgroundColor =  #colorLiteral(red: 0.1450815201, green: 0.1451086104, blue: 0.1450755298, alpha: 1)
        
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        
        let searchField = searchController.searchBar.searchTextField
        searchField.tintColor = .black
        searchField.backgroundColor = .white
    }
    
    private func updataPositionButtonBar() {
        let originX = (segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)) * CGFloat(segmentedControl.selectedSegmentIndex)
        buttonBar.frame.origin.x = originX
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        resetItemWhenChangeValue()
        searchAnItem(text: searchController.searchBar.text)
        
        UIView.animate(withDuration: 0.3) {
            self.updataPositionButtonBar()
        }
    }
}

//MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            resetItemWhenChangeValue()
            searchAnItem(text: text)
        }
    }

}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as ResultSearchCell
        cell.setUpCell(with: items[indexPath.row])
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.TableView.heightForRow
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.items.count - 1 {
            self.loadMore()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch segmentedControl.selectedSegmentIndex {
        
        //Track
        case 0:
            guard let track = items[indexPath.row] as? Track else { return }
            let trackDetailViewController = TrackDetailViewController()
            trackDetailViewController.track = track
            trackDetailViewController.modalPresentationStyle = .overFullScreen
            present(trackDetailViewController, animated: true, completion: nil)
            
        //Albums
        case 2:
            guard let album = items[indexPath.row] as? Album else { return }
            let albumDetailViewController = AlbumDetailViewController()
            albumDetailViewController.album = album
            navigationController?.pushViewController(albumDetailViewController, animated: true)
            
        // Playlists
        case 3:
            guard let playlist = items[indexPath.row] as? Playlist else { return }
            guard let playlistDetailVC = AppStoryboard.playlistDetail.instantiateInitialViewController() as? PlaylistDetailViewController else { return }
            playlistDetailVC.playlist = playlist
            navigationController?.pushViewController(playlistDetailVC, animated: true)
        default:
            break
        }
    }
    
    private func loadMore() {
        if offset + limit <= total {
            offset += limit
            searchAnItem(text: searchController.searchBar.text)
        } else if offset != total {
            offset = total
            searchAnItem(text: searchController.searchBar.text)
        }
    }
   
}


