//
//  DetailTableViewCell.swift
//  Soundify
//
//  Created by Viet Anh on 3/13/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit
import Reusable
import SnapKit

final class TrackAlbumDetailTableViewCell: UITableViewCell, NibReusable {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    func setUpCell(with track: Track) {
        backgroundColor = #colorLiteral(red: 0.09718047827, green: 0.07773689181, blue: 0.07808386534, alpha: 1)
        titleLabel.text = track.name
        descriptionLabel.text = track.artists.map { $0.name }.joined(separator: ", ")
    }
}
