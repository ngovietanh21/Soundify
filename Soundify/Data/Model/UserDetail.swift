//
//  UserDetail.swift
//  Soundify
//
//  Created by Viet Anh on 3/16/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

struct UserDetail: BaseModel {
    var displayName: String?
    var externalUrls: ExternalUrl
    var followers: Follower
    var href: String = ""
    var id: String = ""
    var images: [Image]
    var type: String = ""
    var uri: String = ""
}
