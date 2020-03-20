//
//  SceneDelegate.swift
//  Soundify
//
//  Created by Viet Anh on 2/24/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if UserSession.shared.accessToken != nil {
            if let mainTabBar = AppStoryboard.main.instantiateInitialViewController() {
                window?.rootViewController = mainTabBar
                window?.makeKeyAndVisible()
            }
        } else if let loginScene = AppStoryboard.login.instantiateInitialViewController() {
            window?.rootViewController = loginScene
            window?.makeKeyAndVisible()
        }
        
    }
}

