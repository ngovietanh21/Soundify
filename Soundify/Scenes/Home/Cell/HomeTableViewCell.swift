//
//  HomeTableViewCell.swift
//  Soundify
//
//  Created by Viet Anh on 3/4/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit
import Reusable
import SDWebImage

final class HomeTableViewCell: UITableViewCell, NibReusable {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var albumImageView: UIImageView!
    @IBOutlet private weak var titleLable: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    func setUpCell(with album: Album) {
        backgroundColor = #colorLiteral(red: 0.09718047827, green: 0.07773689181, blue: 0.07808386534, alpha: 1)
        titleLable.text = album.name
        descriptionLabel.text = getDescription(of: album)
        if let url = getUrlImage(of: album) {
            albumImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    private func getDescription(of album: Album) -> String {
        return album.artists.map { $0.name }.joined(separator: ", ")
    }
    
    private func getUrlImage(of album: Album) -> URL? {
        let stringURL = album.images.filter { $0.height == 64 }.last?.url
        return URL(string: stringURL ?? "")
    }
}

