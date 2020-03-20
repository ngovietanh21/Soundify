//
//  BaseDetailViewController.swift
//  Soundify
//
//  Created by Viet Anh on 3/15/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit

class BaseDetailViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

}
