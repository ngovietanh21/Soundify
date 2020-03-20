//
//  UserRepository.swift
//  Soundify
//
//  Created by Viet Anh on 2/27/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation
import WebKit

struct UserRepository {
    
    static let shared = UserRepository()
    
    private let spotifyService = SpotifyService()
    private let userSession = UserSession()
    private var accessToken: String? {
        return userSession.accessToken
    }
    
    func login(on webView: WKWebView) {
        guard let url = URL(string: URLs.authorization) else { return }
        let urlRequest = URLRequest(url: url)
        webView.load(urlRequest)
    }
    
    func requestToken(with code: String, completion: @escaping (BaseResult<Token>?) -> Void) {
        UserSession.shared.saveCode(code)
        
        let key = APIKey.CLIENT_ID + ":" + APIKey.CLIENT_SECRET
        guard let keyBase64String = key.data(using: .utf8)?.base64EncodedString() else { return }
        
        let header = ["Authorization": "Basic " + keyBase64String]
        
        let parameters = [
            "grant_type": "authorization_code",
            "code": code,
            "redirect_uri": Constants.REDIRECT_URI
        ]
        
        let request = BaseRequest(URLs.token, .post, header: header, parameter: parameters)
        
        spotifyService.request(input: request) { (token: Token?, error) in
            if let error = error  {
                completion(.failure(error: error))
            } else if let token = token {
                UserSession.shared.saveToken(token)
                completion(.success(token))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
    
    func getListOfNewReleases(limit: Int, offset: Int,completion: @escaping (BaseResult<SpotifySearch>?) -> Void) {
        guard let accessToken = accessToken else { return }
        
        let header = ["Authorization": "Bearer \(accessToken)"]
        let urlString = URLs.newReleases + "?offset=\(offset)&limit=\(limit)"
        
        let request = BaseRequest(urlString, .get, header: header)
        
        spotifyService.request(input: request) { (result: SpotifySearch?, error) in
            if let error = error  {
                completion(.failure(error: error))
            } else if let result = result {
                completion(.success(result))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
    
    func getListOfCurrentUserPlaylists(completion: @escaping (BaseResult<SpotifyObject<Playlist>>?) -> Void) {
        guard let accessToken = accessToken else { return }
        
        let header = ["Authorization": "Bearer \(accessToken)"]
        
        let request = BaseRequest(URLs.currentUserPlaylist, .get, header: header)
        
        spotifyService.request(input: request) { (result: SpotifyObject<Playlist>?, error) in
            if let error = error  {
                completion(.failure(error: error))
            } else if let result = result {
                completion(.success(result))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
    
    func searchForAnItem(query: String, type: String, limit: Int, offset: Int, completion: @escaping (BaseResult<SpotifySearch>?) -> Void) {
        guard let accessToken = accessToken else { return }
        
        let header = ["Authorization": "Bearer \(accessToken)"]
        
        let encodeQuery = query.replacingOccurrences(of: " ", with: "%20")
        let urlString = URLs.search + "q=\(encodeQuery)&type=\(type)" + "&limit=\(limit)&offset=\(offset)"
        
        let request = BaseRequest(urlString, .get, header: header)
        
        spotifyService.request(input: request) { (result: SpotifySearch?, error) in
            if let error = error  {
                completion(.failure(error: error))
            } else if let result = result {
                completion(.success(result))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
    
    func getAnAlbumDetail(album: Album, completion: @escaping (BaseResult<AlbumDetail>?) -> Void) {
        guard let accessToken = accessToken else { return }
        
        let header = ["Authorization": "Bearer \(accessToken)"]
        
        let urlString = URLs.albums + "\(album.id)"
        
        let request = BaseRequest(urlString, .get, header: header)
        
        spotifyService.request(input: request) { (result: AlbumDetail?, error) in
            if let error = error  {
                completion(.failure(error: error))
            } else if let result = result {
                completion(.success(result))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
    
    func getPlaylistDetail(playlist: Playlist, completion: @escaping (BaseResult<PlaylistDetail>?) -> Void) {
        guard let accessToken = accessToken else { return }
        
        let header = ["Authorization": "Bearer \(accessToken)"]
        
        let urlString = URLs.playlists + "\(playlist.id)"
        
        let request = BaseRequest(urlString, .get, header: header)
        
        spotifyService.request(input: request) { (result: PlaylistDetail?, error) in
            if let error = error  {
                completion(.failure(error: error))
            } else if let result = result {
                completion(.success(result))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
    
    func getPlaylistDetailTrack(limit: Int, offset: Int ,playlist: Playlist,
                                completion: @escaping (BaseResult<SpotifyObject<PlaylistDetailTrack>>?) -> Void) {
        guard let accessToken = accessToken else { return }
        
        let header = ["Authorization": "Bearer \(accessToken)"]
        
        let urlString = URLs.playlists + "\(playlist.id)/tracks?limit=\(limit)&offset=\(offset)"
        
        let request = BaseRequest(urlString, .get, header: header)
        
        spotifyService.request(input: request) { (result: SpotifyObject<PlaylistDetailTrack>?, error) in
            if let error = error  {
                completion(.failure(error: error))
            } else if let result = result {
                completion(.success(result))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
    
    func getSeveralArtistsDetail(artists: [Artis], completion: @escaping (BaseResult<Artists>?) -> Void) {
        guard let accessToken = accessToken else { return }
        
        let header = ["Authorization": "Bearer \(accessToken)"]
        
        var urlString = URLs.artists + "ids="
        for artist in artists {
            urlString += "\(artist.id),"
        }
        urlString.removeLast()
        
        let request = BaseRequest(urlString, .get, header: header)
        
        spotifyService.request(input: request) { (result: Artists?, error) in
            if let error = error  {
                completion(.failure(error: error))
            } else if let result = result {
                completion(.success(result))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
    
    func getUsersProfile(user: User, completion: @escaping (BaseResult<UserDetail>?) -> Void) {
        guard let accessToken = accessToken else { return }
        
        let header = ["Authorization": "Bearer \(accessToken)"]
        
        let urlString = URLs.users + "\(user.id)"
        
        let request = BaseRequest(urlString, .get, header: header)
        
        spotifyService.request(input: request) { (result: UserDetail?, error) in
            if let error = error  {
                completion(.failure(error: error))
            } else if let result = result {
                completion(.success(result))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
    
    func getATrack(track: Track, completion: @escaping (BaseResult<Track>?) -> Void) {
        guard let accessToken = accessToken else { return }
        
        let header = ["Authorization": "Bearer \(accessToken)"]
        
        let urlString = URLs.tracks + "\(track.id)"
        
        let request = BaseRequest(urlString, .get, header: header)
        
        spotifyService.request(input: request) { (result: Track?, error) in
            if let error = error  {
                completion(.failure(error: error))
            } else if let result = result {
                completion(.success(result))
            } else {
                completion(.failure(error: nil))
            }
        }
    }
}


