//
//  BaseRequest.swift
//  Soundify
//
//  Created by Viet Anh on 2/27/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

struct BaseRequest {
    var url = ""
    var requestType: RequestType = .get
    var header: [String: String]?
    var parameter: [String: Any]?
    
    init(_ url: String,_ requestType: RequestType) {
        self.url = url
        self.requestType = requestType
    }
    
    init(_ url: String,_ requestType: RequestType, header: [String: String]?) {
        self.url = url
        self.requestType = requestType
        self.header = header
    }
    
    init(_ url: String,_ requestType: RequestType, header: [String: String]?, parameter: [String: Any]?) {
        self.url = url
        self.requestType = requestType
        self.header = header
        self.parameter = parameter
    }
}
