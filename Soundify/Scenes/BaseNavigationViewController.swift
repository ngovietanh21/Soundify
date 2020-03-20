//
//  BaseNavigationViewController.swift
//  Soundify
//
//  Created by Viet Anh on 2/29/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.barTintColor = .black
        navigationBar.barStyle = .black
        navigationBar.tintColor = .white
        navigationBar.isTranslucent = true
    }
}
