//
//  SpotifySearch.swift
//  Soundify
//
//  Created by Viet Anh on 2/26/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

struct SpotifySearch: Codable {
    var albums: SpotifyObject<Album>?
    var artists: SpotifyObject<Artis>?
    var tracks: SpotifyObject<Track>?
    var playlists: SpotifyObject<Playlist>?
}
