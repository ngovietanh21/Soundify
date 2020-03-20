//
//  Image.swift
//  Soundify
//
//  Created by Viet Anh on 2/26/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

//https://developer.spotify.com/documentation/web-api/reference/object-model/#image-object
struct Image: BaseModel {
    let height: Int?
    let width: Int?
    let url: String
}
