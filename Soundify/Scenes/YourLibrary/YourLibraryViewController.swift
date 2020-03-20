//
//  YourLibraryViewController.swift
//  Soundify
//
//  Created by Viet Anh on 2/28/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit
import Reusable
import WebKit

final class YourLibraryViewController: BaseViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var items: [Playlist] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        fetchListOfCurrentUserPlaylists()
    }
    
    private func configView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: YourLibraryTableViewCell.self)
    }
    
    private func fetchListOfCurrentUserPlaylists() {
        UserRepository.shared.getListOfCurrentUserPlaylists { [weak self] result in
            switch result {
            case .success(let result):
                guard let userPlaylists = result?.items else { return }
                self?.items += userPlaylists
            case .failure(let error):
                self?.showErrorAlert(message: error.debugDescription)
            default:
                break
            }
        }
    }
}
//MARK: - UITableViewDataSource
extension YourLibraryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as YourLibraryTableViewCell
        switch indexPath.row {
        case 0:
            cell.setUpFirstCell()
        default:
            cell.setUpCell(with: items[indexPath.row - 1])
        }
        return cell
    }
}
//MARK: - UITableViewDelegate
extension YourLibraryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.TableView.heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            return
        default:
            guard let playlistDetailVC = AppStoryboard.playlistDetail.instantiateInitialViewController()
                                                        as? PlaylistDetailViewController else { return }
            playlistDetailVC.playlist = items[indexPath.row - 1]
            navigationController?.pushViewController(playlistDetailVC, animated: true)
        }
        
    }
}
//MARK: - WebKit
extension YourLibraryViewController {
    @IBAction func logoutBarButtonClicked(_ sender: UIBarButtonItem) {
        UserSession.shared.clearUserData()
        clearCookies()
        guard let loginScene = AppStoryboard.login.instantiateInitialViewController() else { return }
        DispatchQueue.main.async {
            loginScene.modalPresentationStyle = .overFullScreen
            self.present(loginScene, animated: true)
        }
    }
    
    private func clearCookies() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                print("[WebCacheCleaner] Record \(record) deleted")
            }
        }
    }
}
