//
//  AlbumDetail.swift
//  Soundify
//
//  Created by Viet Anh on 3/13/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

struct AlbumDetail: BaseModel {
    var albumType: String = ""
    var artists: [Artis] = []
    var availableMarkets: [String] = []
    var copyrights: [Copyright]
    var externalUrls: ExternalUrl
    var href: String = ""
    var id: String = ""
    var images: [Image] = []
    var label: String
    var name: String = ""
    var releaseDate: Date?
    var tracks: SpotifyObject<Track>
    var type: String = ""
    var uri: String = ""
}
