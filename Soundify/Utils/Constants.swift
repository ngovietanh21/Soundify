//
//  Constants.swift
//  Soundify
//
//  Created by Viet Anh on 2/26/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation
import UIKit

//MARK: - Spotify Authorization
struct Constants {
    private static let scopes = ["user-modify-playback-state",
    "user-top-read",
    "playlist-read-private",
    "playlist-modify-private",
    "user-read-private",
    "playlist-read-collaborative",
    "user-library-read","streaming"]
    
    public static var encodedScopes: String {
        return scopes.joined(separator: "%20")
    }
    
    public static let REDIRECT_URI = "soundify://"
    public static let responseQuery = REDIRECT_URI + "?code="
}

//MARK: - TableView
extension Constants {
    struct TableView {
        static let heightForRow: CGFloat = 90.0
        static let heightForRowDetail: CGFloat = 70.0
        static let heightForRowCopyright: CGFloat = 60.0
        static let heightForRowTrackPlaylistDetail: CGFloat = 75.0
        static let heightForRowHeaderDetail: CGFloat = 165.0
        static let heightForHeaderInSection: CGFloat = 70.0
    }
}

//MARK: - Header Title
extension Constants {
    struct HeaderTitle {
       static let newRelease = "New Releases"
    }
}
