//
//  UIView+.swift
//  Soundify
//
//  Created by Viet Anh on 2/29/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation
import UIKit

//Source: https://stackoverflow.com/questions/26961274/how-can-i-make-a-button-have-a-rounded-border-in-swift
@IBDesignable extension UIView {
    
    func makeRounded() {
        layer.masksToBounds = false
        cornerRadius = self.frame.height / 2
        clipsToBounds = true
    }
    
    func makeSquare() {
        layer.masksToBounds = false
        cornerRadius = 0
        clipsToBounds = true
    }
    
    @IBInspectable var borderWidth: CGFloat {
        set {
            DispatchQueue.main.async {
                self.layer.borderWidth = newValue
            }
        }
        get {
            return layer.borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        set {
            DispatchQueue.main.async {
                self.layer.cornerRadius = newValue
            }
        }
        get {
            return layer.cornerRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            DispatchQueue.main.async {
                self.layer.borderColor = uiColor.cgColor
            }
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
