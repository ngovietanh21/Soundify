//
//  Token.swift
//  Soundify
//
//  Created by Viet Anh on 2/27/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

/*
Response from the token endpoint will look something like
{
   "access_token": "NgCXRK...MzYjw",
   "token_type": "Bearer",
   "scope": "user-read-private user-read-email",
   "expires_in": 3600,
   "refresh_token": "NgAagA...Um_SHo"
}
So you have to set keyDecodingStrategy before decode
let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase
*/
struct Token: Codable {
    let scope: String
    let accessToken: String
    let expiresIn: Int
    let refreshToken: String
    let tokenType: String
}
