//
//  Int+.swift
//  Soundify
//
//  Created by Viet Anh on 3/14/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

extension Int {
    
    var msToSeconds: Double {
        return Double(self) / 1000
    }
    
    var commaSeparator: String {
        return Formatter.separatorNumberWithComma.string(for: self) ?? ""
    }
}
