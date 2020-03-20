//
//  ArtistAlbumDetailTableViewCell.swift
//  Soundify
//
//  Created by Viet Anh on 3/13/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit
import Reusable

final class ArtistAlbumDetailTableViewCell: UITableViewCell, NibReusable {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var artistImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    func setUpCell(with artist: Artis) {
        backgroundColor = #colorLiteral(red: 0.09718047827, green: 0.07773689181, blue: 0.07808386534, alpha: 1)
        titleLabel.text = artist.name
        
        artistImageView.makeRounded()
        artistImageView.sd_setImage(with: URL(string: artist.images?.last?.url ?? ""), completed: nil)
    }
}
