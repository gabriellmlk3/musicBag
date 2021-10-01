//
//  MusicModel.swift
//  Music Bag
//
//  Created by Premier on 17/09/21.
//

import UIKit

class MusicModel: Codable {
    
    let trackName: String
    let trackImage: String
    let trackAuthor: String?
    let trackID: String
    let trackURL: String?
    var isLoved: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case trackName = "track_name"
        case trackImage = "track_image"
        case trackAuthor = "track_author"
        case trackID = "trackID"
        case trackURL = "trackURL"
        case isLoved = "isLoved"
        
    }
    
    init(trackName: String, trackAuthor: String?, trackImage: String, trackURL: String? = nil, trackID: String) {
        self.trackName = trackName
        self.trackAuthor = trackAuthor == nil || trackAuthor == "" ? "Unknow" : trackAuthor
        self.trackImage = trackImage
        self.trackID = trackID
        self.trackURL = trackURL
    }
    

}
