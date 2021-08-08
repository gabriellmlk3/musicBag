//
//  VideoModel.swift
//  Music Bag
//
//  Created by Premier on 06/08/21.
//

import Foundation

struct VideoModel: Codable {
    var items: [Items]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
}

struct Items: Codable {
    var kind: String
    var etag: String
    var id: ID
    var snippet: Snippet
    
    enum CodingKeys: String, CodingKey {
        case kind, etag, id, snippet
    }
}

struct ID: Codable {
    var kind: String
    var videoID: String
    
    enum CodingKeys: String, CodingKey {
        case kind
        case videoID = "VideoId"
    }
    
}

struct Snippet: Codable {
    var publishedAt: String
    var channelId: String
    var title: String
    var description: String
    var thumbnails: String
    
    enum CodingKeys: String, CodingKey {
        case publishedAt, channelId, title, description, thumbnails
    }
}

struct Thumbnails: Codable {
    var defaultQuality: String
    
    enum CodingKeys: String, CodingKey {
        case defaultQuality = "default"
    }
}


