//
//  Track.swift
//  Soundify
//
//  Created by Viet Anh on 2/26/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

//https://developer.spotify.com/documentation/web-api/reference/object-model/#track-object-full
// The external_urls key in JSON will be mapped to externalUrls by .convertFromSnakeCase
// So you have to set keyDecodingStrategy before decode
// let decoder = JSONDecoder()
// decoder.keyDecodingStrategy = .convertFromSnakeCase
struct Track: BaseModel {
    var album: Album?
    var artists: [Artis] = []
    var availableMarkets: [String] = []
    var discNumber: Int = 0
    var durationMs: Int = 0
    var externalUrls: ExternalUrl
    var href: String = ""
    var id: String = ""
    var name: String = ""
    var previewUrl: String?
    var trackNumber: Int = 0
    var type: String = ""
    var uri: String = ""
}
