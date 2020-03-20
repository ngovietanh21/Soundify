//
//  User.swift
//  Soundify
//
//  Created by Viet Anh on 2/26/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

//https://developer.spotify.com/documentation/web-api/reference/object-model/#user-object-public
// The external_urls key in JSON will be mapped to externalUrls by .convertFromSnakeCase
// So you have to set keyDecodingStrategy before decode
// let decoder = JSONDecoder()
// decoder.keyDecodingStrategy = .convertFromSnakeCase
struct User: BaseModel {
    var displayName: String = ""
    var externalUrls: ExternalUrl
    var href: String = ""
    var id: String = ""
    var type: String = ""
    var uri: String = ""
}
