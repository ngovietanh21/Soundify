//
//  AppStoryboard.swift
//  Soundify
//
//  Created by Viet Anh on 2/28/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation
import UIKit

enum AppStoryboard : String {
    case main = "Main"
    case login = "Login"
    case home = "Home"
    case search = "Search"
    case yourLibrary = "YourLibrary"
    case playlistDetail = "PlaylistDetail"
    
    var instance : UIStoryboard {
        return UIStoryboard(name: self.rawValue, bundle: .main)
    }
    
    func instantiateInitialViewController() -> UIViewController? {
        return UIStoryboard(name: self.rawValue, bundle: .main).instantiateInitialViewController()
    }
    
    func instantiateViewController<T: UIViewController>(withIdentifier identifier: String, class: T.Type) -> T? {
        return UIStoryboard(name: self.rawValue, bundle: .main).instantiateViewController(withIdentifier: identifier) as? T
    }
}
