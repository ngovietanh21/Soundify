//
//  URLs.swift
//  Soundify
//
//  Created by Viet Anh on 2/26/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

struct URLs {
    //MARK: - Private
    private static let APIBaseAuthorizationUrl = "https://accounts.spotify.com/authorize"
    private static let APIBaseUrl = "https://api.spotify.com/v1"
    
    //MARK: - Public
    public static let authorization = APIBaseAuthorizationUrl + "?response_type=code&client_id=" + APIKey.CLIENT_ID + "&scope=" + Constants.encodedScopes + "&redirect_uri=" + Constants.REDIRECT_URI + "&show_dialog=false"
    
    public static let token = "https://accounts.spotify.com/api/token"
    
    public static let user = APIBaseUrl + "/me" 
    public static let newReleases = APIBaseUrl + "/browse/new-releases"
    public static let currentUserPlaylist = APIBaseUrl + "/me/playlists"
    public static let search = APIBaseUrl +  "/search?"
    public static let albums = APIBaseUrl + "/albums/"
    public static let playlists = APIBaseUrl + "/playlists/"
    public static let artists = APIBaseUrl + "/artists?"
    public static let users = APIBaseUrl + "/users/"
    public static let tracks = APIBaseUrl + "/tracks/"
}
