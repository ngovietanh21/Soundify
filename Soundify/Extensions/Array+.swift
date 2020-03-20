//
//  Array+.swift
//  Soundify
//
//  Created by Viet Anh on 3/16/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

extension Array where Element == Artis {
    
    var sequenceNameArtistsWithDot: String? {
        return self.map { $0.name }.joined(separator: " • ")
    }
    
    var sequenceNameArtistsWithComma: String {
        return self.map { $0.name }.joined(separator: ", ")
    }
    
}

extension Array where Element == Image {
    
    var urlImage: URL? {
        return URL(string: self.first?.url ?? "")
    }
    
}
