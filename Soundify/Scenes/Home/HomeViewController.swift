//
//  HomeViewController.swift
//  Soundify
//
//  Created by Viet Anh on 2/29/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit
import Reusable

final class HomeViewController: BaseViewController {
    private var total = 0
    private var limit = 20
    private var offset = 0
    
    private var items: [Album] = []
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        fetchListOfNewReleases()
    }
    
    private func configView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: HomeTableViewCell.self)
    }
    
    private func loadMore() {
        if offset + limit <= total {
            offset += limit
            fetchListOfNewReleases()
        } else if offset != total {
            offset = total
            fetchListOfNewReleases()
        }
    }
    
    private func fetchListOfNewReleases() {
        UserRepository.shared.getListOfNewReleases(limit: limit, offset: offset) { [weak self] result in
            switch result {
            case .success(let result):
                guard let albums = result?.albums else { return }
                self?.items += albums.items
                self?.total = albums.total
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
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
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as HomeTableViewCell
        cell.setUpCell(with: items[indexPath.row])
        return cell
    }
}
//MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return HeaderView(frame: tableView.frame, title: Constants.HeaderTitle.newRelease)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Constants.TableView.heightForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.TableView.heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let albumDetailViewController = AlbumDetailViewController()
        albumDetailViewController.album = items[indexPath.row]
        navigationController?.pushViewController(albumDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.items.count - 1 {
            self.loadMore()
        }
    }
}
