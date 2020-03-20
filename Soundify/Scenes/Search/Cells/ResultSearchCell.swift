//
//  ResultSearchCell.swift
//  Soundify
//
//  Created by Viet Anh on 3/11/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit
import Reusable
import SnapKit

final class ResultSearchCell: UITableViewCell, NibReusable {
    
    //MARK: - IBOutlet
    @IBOutlet private weak var resultImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    func setUpCell(with item: Any) {
        backgroundColor = #colorLiteral(red: 0.09718047827, green: 0.07773689181, blue: 0.07808386534, alpha: 1)
        descriptionLabel.alpha = 1.0
        resultImageView.makeSquare()
        titleLabel.font = .systemFont(ofSize: 21.0, weight: .regular)
        titleLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(-15)
        }
    
        switch item {
        case let track as Track:
            setUpCell(with: track)
            
        case let artist as Artis:
            setUpCell(with: artist)
            
        case let album as Album:
            setUpCell(with: album)
            
        case let playlist as Playlist:
            setUpCell(with: playlist)
            
        default:
            break
        }
    }
    
    private func setUpCell(with track: Track) {
        titleLabel.text = track.name
        
        descriptionLabel.text = track.artists.map { $0.name }.joined(separator: ", ")
        
        if let url = URL(string: track.album?.images.last?.url ?? "") {
            resultImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    private func setUpCell(with artist: Artis) {
        descriptionLabel.alpha = 0.0
        
        titleLabel.text = artist.name
        titleLabel.font = .systemFont(ofSize: 21.0, weight: .semibold)
        titleLabel.snp.remakeConstraints { (make) in
            make.centerY.equalTo(self.snp.centerY).offset(0)
        }
        
        resultImageView.makeRounded()
        if let url = URL(string: artist.images?.last?.url ?? "") {
            resultImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    private func setUpCell(with album: Album) {
        titleLabel.text = album.name
        
        descriptionLabel.text = album.artists.map { $0.name }.joined(separator: ", ")
        
        if let url = URL(string: album.images.last?.url ?? "") {
            resultImageView.sd_setImage(with: url, completed: nil)
        }
    }
    
    private func setUpCell(with playlist: Playlist) {
        titleLabel.text = playlist.name
        
        descriptionLabel.text = "By \(playlist.owner.displayName) - \(playlist.tracks.total) SONGS"
        
        if let url = URL(string: playlist.images.first?.url ?? "" ) {
            resultImageView.sd_setImage(with: url, completed: nil)
        }
    }
}
