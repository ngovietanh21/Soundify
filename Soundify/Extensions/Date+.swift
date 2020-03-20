//
//  Date+.swift
//  Soundify
//
//  Created by Viet Anh on 3/17/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation
import Then

// MARK: - Date format
extension Date {
    enum Formatter {
        case day
        case year
        case month
        case monthName
        
        var format: String {
            switch self {
            case .day:
                return "dd"
            case .year:
                return "yyyy"
            case .month:
                return "MM"
            case .monthName:
                return "MMMM"
            }
        }
        
        var instance: DateFormatter {
            return DateFormatter().then {
                $0.dateFormat = format
                $0.calendar = Calendar.current
                $0.locale = Calendar.current.locale
                $0.timeZone = Calendar.current.timeZone
            }
        }
    }
}

extension DateFormatter {
    
    static func from(format: String) -> DateFormatter {
        return DateFormatter().then {
            $0.dateFormat = format
            $0.calendar = Calendar.current
            $0.locale = Calendar.current.locale
            $0.timeZone = Calendar.current.timeZone
        }
    }
}

extension Date {
    
    func toString(format: Formatter) -> String {
        return toString(format: format.instance)
    }
    
    func toString(format: DateFormatter) -> String {
        return format.string(from: self)
    }

}

// MARK: - Get date, month, year, day,... in string
extension Date {
    var yearString: String {
        return self.toString(format: Formatter.year)
    }

    var monthString: String {
        return self.toString(format: Formatter.month)
    }
    
    var monthNameString: String {
        return self.toString(format: Formatter.monthName)
    }
    
    var dateString: String {
        return self.toString(format: Formatter.day)
    }
}

