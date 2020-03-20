//
//  Formatter+.swift
//  Soundify
//
//  Created by Viet Anh on 3/16/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation
import Then

extension Formatter {
    
    static let separatorNumberWithComma: NumberFormatter = {
        return NumberFormatter().then {
            $0.groupingSeparator = ","
            $0.numberStyle = .decimal
        }
    }()
}
