//
//  YourLibraryTableViewCell.swift
//  Soundify
//
//  Created by Viet Anh on 3/7/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit
import Reusable
import SnapKit
import SDWebImage

final class YourLibraryTableViewCell: UITableViewCell, NibReusable {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var playlistImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionsLabel: UILabel!
    
    func setUpCell(with playlist: Playlist) {
        backgroundColor = #colorLiteral(red: 0.09718047827, green: 0.07773689181, blue: 0.07808386534, alpha: 1)
        titleLabel.text = playlist.name
        descriptionsLabel.text = "By \(playlist.owner.displayName) - \(playlist.tracks.total) SONGS"
        if let url = URL(string: playlist.images.first?.url ?? "" ) {
           playlistImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    func setUpFirstCell() {
        backgroundColor = #colorLiteral(red: 0.09718047827, green: 0.07773689181, blue: 0.07808386534, alpha: 1)
        descriptionsLabel.alpha = 0.0
        playlistImageView.image = #imageLiteral(resourceName: "icon_add_playlist").withTintColor(.white)
        
        titleLabel.text = "Create new playlist"
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
        }
    }
}
