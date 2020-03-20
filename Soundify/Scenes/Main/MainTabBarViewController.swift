//
//  MainTabBarViewController.swift
//  Soundify
//
//  Created by Viet Anh on 2/29/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabBar()
        setUpViewControllers()
    }
    
    private func setUpTabBar() {
        tabBar.tintColor = .white
        tabBar.barTintColor = .black
        tabBar.isTranslucent = true
    }
    
    private func setUpViewControllers() {
        guard let homeViewController = initialiseViewController(name: .home,
                                                                image: #imageLiteral(resourceName: "tab_icon_home"),
                                                                selectedImage: #imageLiteral(resourceName: "tab_icon_home_filled")) else { return }
        
        guard let searchViewController = initialiseViewController(name: .search,
                                                                  image: #imageLiteral(resourceName: "tab_icon_search"),
                                                                  selectedImage: #imageLiteral(resourceName: "tab_icon_search")) else { return }
        
        guard let libraryViewController = initialiseViewController(name: .yourLibrary,
                                                                   image: #imageLiteral(resourceName: "tab_icon_library"),
                                                                   selectedImage: #imageLiteral(resourceName: "tab_icon_library_filled")) else { return }
        
        viewControllers = [homeViewController, searchViewController, libraryViewController]
    }
    
    private func initialiseViewController(name: AppStoryboard, image: UIImage, selectedImage: UIImage) -> UIViewController? {
        guard let viewController = name.instantiateInitialViewController() else { return nil }
        viewController.tabBarItem = UITabBarItem(title: name.rawValue, image: image, selectedImage: selectedImage)
        return viewController
    }
}
