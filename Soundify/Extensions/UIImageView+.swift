//
//  UIImageView+.swift
//  Soundify
//
//  Created by Viet Anh on 3/4/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func load(_ url: URL) {
        let concurrentQueue = DispatchQueue(label: "download_image", qos: .default, attributes: .concurrent)
        concurrentQueue.async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
