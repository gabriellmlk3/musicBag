//
//  APIManager.swift
//  Music Bag
//
//  Created by Premier on 06/08/21.
//

import Foundation

enum Endpoint: String {
    case youTube = "/youtube/v3/"
    case result = "result"
}

enum SolicitationParam: String {
    case part = "part"
    case field = "field"
}

struct CreateURL {
    let path: String?
    let queryItems: [URLQueryItem]
    
    static func urlToResults(endpoint: Endpoint) -> CreateURL {
        return CreateURL(
            path: nil,
            queryItems: []
        )
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = NetworkManager.shared.baseUrl
        return components.url
    }
    
    
}
