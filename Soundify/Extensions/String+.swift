//
//  String+.swift
//  Soundify
//
//  Created by Viet Anh on 3/11/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

extension String {
    
    var encodeForSearch: String {
        get {
            var newString = self.lowercased()
            newString.removeLast()
            return newString
        }
    }
}
