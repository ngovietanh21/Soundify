//
//  PlaylistDetail.swift
//  Soundify
//
//  Created by Viet Anh on 3/13/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

struct PlaylistDetail: BaseModel {
    var description: String = ""
    var externalUrls: ExternalUrl
    var followers: Follower
    var href: String = ""
    var id: String = ""
    var images: [Image] = []
    var name: String = ""
    var owner: User
    var snapshotId: String = ""
    var type: String = ""
    var uri: String = ""
}
