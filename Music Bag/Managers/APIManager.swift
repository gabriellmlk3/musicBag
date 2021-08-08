//
//  APIManager.swift
//  Music Bag
//
//  Created by Premier on 06/08/21.
//

import Foundation

enum Endpoint: String {
    case youTube = "/youtube/v3/search"
}

enum SolicitationParam: String {
    case part = "part"
    case field = "field"
}

struct CreateURL {
    let path: String
    let queryItems: [URLQueryItem]
    
    static func urlQueryToVideo(endpoint: Endpoint, solicitationParam: SolicitationParam, videoID: String, apiKey: String?) -> CreateURL {
        return CreateURL(
            path: endpoint.rawValue,
            queryItems: [
                URLQueryItem(name: "videos", value: ""),
                URLQueryItem(name: "id", value: videoID),
                URLQueryItem(name: "key", value: apiKey),
                URLQueryItem(name: solicitationParam.rawValue, value: "snippets,contentDetails,status")
            ]
        )
    }
    
    static func urlQueryToList(endpoint: Endpoint, apiKey: String?) -> CreateURL {
        return CreateURL(
            path: endpoint.rawValue,
            queryItems: [
                URLQueryItem(name: "part", value: "snippet"),
                URLQueryItem(name: "maxResults", value: "25"),
                URLQueryItem(name: "key", value: apiKey)
            ]
        )
    }
    
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "www.youtube.googleapis.com"
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
    
    
}
