//
//  SpotifyObject.swift
//  Soundify
//
//  Created by Viet Anh on 2/26/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

//https://developer.spotify.com/documentation/web-api/reference/object-model/#paging-object
struct SpotifyObject<T: BaseModel>: BaseModel {
    var href: String
    var items: [T] = []
    var limit: Int
    var next: String?
    var offset: Int
    var previous: String?
    var total: Int
}
