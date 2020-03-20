//
//  Album.swift
//  Soundify
//
//  Created by Viet Anh on 2/26/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

//https://developer.spotify.com/documentation/web-api/reference/object-model/#album-object-full
// The release_date_precision key in JSON will be mapped to releaseDatePrecision by .convertFromSnakeCase
// So you have to set keyDecodingStrategy before decode
// let decoder = JSONDecoder()
// decoder.keyDecodingStrategy = .convertFromSnakeCase
struct Album: BaseModel {
    var albumType: String = ""
    var artists: [Artis] = []
    var availableMarkets: [String] = []
    var externalUrls: ExternalUrl
    var href: String = ""
    var id: String = ""
    var images: [Image] = []
    var name: String = ""
    var type: String = ""
    var uri: String = ""
}
