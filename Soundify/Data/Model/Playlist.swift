//
//  Playlist.swift
//  Soundify
//
//  Created by Viet Anh on 2/26/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

// https://developer.spotify.com/documentation/web-api/reference/object-model/#playlist-object-full
// The external_urls key in JSON will be mapped to externalUrls by .convertFromSnakeCase
// So you have to set keyDecodingStrategy before decode
// let decoder = JSONDecoder()
// decoder.keyDecodingStrategy = .convertFromSnakeCase
struct Playlist: BaseModel {
    var description: String = ""
    var externalUrls: ExternalUrl
    var href: String = ""
    var id: String = ""
    var images: [Image] = []
    var name: String = ""
    var owner: User
    var tracks: PlaylistTrack
    var type: String = ""
    var uri: String = ""
}

struct PlaylistTrack: BaseModel {
    var href: String = ""
    var total: Int = 0
}
