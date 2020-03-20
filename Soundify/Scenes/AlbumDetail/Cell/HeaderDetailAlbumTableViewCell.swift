//
//  HeaderDetailAlbumTableViewCell.swift
//  Soundify
//
//  Created by Viet Anh on 3/14/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit
import Reusable

final class HeaderDetailAlbumTableViewCell: UITableViewCell, NibReusable {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var artistsLabel: UILabel!
    @IBOutlet private weak var typeAlbumLabel: UILabel!
    
    func setUpView(with album: Album, releaseDate: Date, artists: [Artis]) {
        backgroundColor = #colorLiteral(red: 0.09718047827, green: 0.07773689181, blue: 0.07808386534, alpha: 1)
        typeAlbumLabel.text = album.albumType.capitalized + " • " + releaseDate.yearString
        nameLabel.text = album.name
        artistsLabel.text = artists.sequenceNameArtistsWithDot
    }
    
}
