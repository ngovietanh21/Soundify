//
//  BaseResult.swift
//  Soundify
//
//  Created by Viet Anh on 2/27/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

enum BaseResult<T: Codable> {
    case success(T?)
    case failure(error: Error?)
}
