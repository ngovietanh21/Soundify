//
//  UISegmentedControl+.swift
//  Soundify
//
//  Created by Viet Anh on 3/9/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation
import UIKit

extension UISegmentedControl {
    func removeSeparators(withBackgroundColor: UIColor, tintColor: UIColor) {
        setBackgroundImage(imageColor(color: withBackgroundColor), for: .normal, barMetrics: .default)
        setBackgroundImage(imageColor(color: tintColor), for: .selected, barMetrics: .default)
        setDividerImage(imageColor(color: .clear), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
    }
    
    private func imageColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width:  1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(rect)
            
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                return image
            }
        }
        
        return UIImage()
    }
}
