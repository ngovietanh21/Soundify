//
//  TimeInterval+.swift
//  Soundify
//
//  Created by Viet Anh on 3/14/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

extension TimeInterval {
    
    var formatterFullTimes: String {
        if hours == 0 {
           return String(format: "%dmin", minute)
        } else {
           return String(format: "%dh %dm", hours, minute)
        }
    }
    
    var formatterMinuteAndSecondInTrack: String {
        return String(format:"%d:%02d", minute, second)
    }
    
    var formatterOnlyMinuteAndSecond: String {
        return String(format:"%d min %02d sec", minute, second)
    }
    
    var hours: Int {
        return Int((self/3600).truncatingRemainder(dividingBy: 24))
    }
    
    var minute: Int {
        return Int((self/60).truncatingRemainder(dividingBy: 60))
    }
    
    var second: Int {
        return Int(truncatingRemainder(dividingBy: 60))
    }
}
