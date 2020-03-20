//
//  SpotifyService.swift
//  Soundify
//
//  Created by Viet Anh on 2/25/20.
//  Copyright © 2020 VietAnh. All rights reserved.
//

import Foundation

struct SpotifyService {
    static let shared = SpotifyService()
    
    private var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.from(format: "yyyy-MM-dd"))
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    private func printRequest(_ request: BaseRequest) {
        print("\n------------REQUEST INPUT")
        print("type: %@", request.requestType.rawValue)
        print("\nlink: %@", request.url)
        print("\nheader: %@", request.header ?? "No Header")
        print("\nparameter: %@", request.parameter ?? "No Parameter")
        print("------------ END REQUEST INPUT\n")
    }
    
    func request<T: Codable> (input: BaseRequest, completion: @escaping (_ value: T?,_ error: Error?) -> Void) {
        guard let url = URL(string: input.url) else { return }
        printRequest(input)
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = input.requestType.rawValue
        
        if let header = input.header {
            for (key,value) in header {
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let parameter = input.parameter {
            urlRequest.httpBody = parameter.percentEncoded()
        }
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                completion(nil, error)
            } else {
                guard let data = data else {
                    completion(nil, nil)
                    return
                }
                
                if let result = try? self.decoder.decode(T.self, from: data) {
                    completion(result, nil)
                }
            }
        }.resume()
    }
}
