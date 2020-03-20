//
//  AudioSlider.swift
//  Soundify
//
//  Created by Viet Anh on 3/19/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import UIKit

@IBDesignable
final class AudioSlider: UISlider {
    
    @IBInspectable var thumbImage: UIImage? {
        didSet {
            setThumbImage(thumbImage, for: .normal)
            setThumbImage(thumbImage, for: .highlighted)
        }
    }
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let customBounds = CGRect(origin: bounds.origin, size: CGSize(width: bounds.size.width, height: 4.0))
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
}
