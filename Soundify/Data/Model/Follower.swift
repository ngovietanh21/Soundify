//
//  Follower.swift
//  Soundify
//
//  Created by Viet Anh on 2/26/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

//https://developer.spotify.com/documentation/web-api/reference/object-model/#followers-object
struct Follower: BaseModel {
    let href: String?
    let total: Int
}
