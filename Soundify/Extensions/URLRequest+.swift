//
//  URLRequest+.swift
//  Soundify
//
//  Created by Viet Anh on 2/27/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

//Get code after login to request access_token and refresh_token
//https://developer.spotify.com/documentation/general/guides/authorization-guide/
extension URLRequest {
    func queryString (after key: String) -> String? {
        guard let requestURLString = (self.url?.absoluteString), let range = requestURLString.range(of: key) else { return nil }
        let code = requestURLString[range.upperBound...]
        return String(code)
    }
}
