//
//  UserSession.swift
//  Soundify
//
//  Created by Viet Anh on 2/27/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

struct UserSession {
    
    static let shared = UserSession()
    
    private let userDefault = UserDefaults.standard
    
    //MARK: - UserTokens
    private let accessTokenKey = "com.save.accessTokenKey"
    private let expiresInKey = "com.save.expiresInKey"
    private let refreshTokenKey = "com.save.refreshTokenKey"
    private let tokenTypeKey = "com.save.tokenTypeKey"
    
    var accessToken: String? {
        return userDefault.value(forKey: accessTokenKey) as? String
    }
    
    var refreshToken: String? {
        return userDefault.value(forKey: refreshTokenKey) as? String
    }
    
    private func setValue(value: Any, forKey key: String) {
        userDefault.setValue(value, forKey: key)
    }
    
    func saveToken(_ token: Token) {
        let accessToken = token.accessToken
        let expiresIn = token.expiresIn
        let refreshToken = token.refreshToken
        let tokenType = token.tokenType
        
        setValue(value: accessToken, forKey: accessTokenKey)
        setValue(value: expiresIn, forKey: expiresInKey)
        setValue(value: refreshToken, forKey: refreshTokenKey)
        setValue(value: tokenType, forKey: tokenTypeKey)
    }
    
    private func removeObject(forKey key: String) {
        userDefault.removeObject(forKey: key)
    }
    
    func clearUserData(){
        removeObject(forKey: accessTokenKey)
        removeObject(forKey: refreshTokenKey)
        removeObject(forKey: expiresInKey)
        removeObject(forKey: tokenTypeKey)
        removeObject(forKey: userCodeKey)
    }
    //MARK: - UserCode
    private let userCodeKey = "com.save.usercodekey"
    
    func saveCode(_ code: String) {
        userDefault.setValue(code, forKey: userCodeKey)
    }
    
    var userCode: String? {
        return userDefault.value(forKey: userCodeKey) as? String
    }
}
