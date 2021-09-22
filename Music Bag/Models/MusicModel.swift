//
//  MusicModel.swift
//  Music Bag
//
//  Created by Premier on 17/09/21.
//

import UIKit

class MusicModel {
    static var shared: [MusicModel] = [MusicModel(trackName: "Behavor", trackTime: 320.0, trackAuthor: nil, trackImage: UIImage(named: "album")!),
                                       MusicModel(trackName: "Anevor", trackTime: 345.0, trackAuthor: nil, trackImage: UIImage(named: "album2")!),
                                       MusicModel(trackName: "Antravor", trackTime: 280.0, trackAuthor: nil, trackImage: UIImage(named: "album3")!),
                                       MusicModel(trackName: "Behavor", trackTime: 320.0, trackAuthor: nil, trackImage: UIImage(named: "album4")!),
                                       MusicModel(trackName: "Anevor", trackTime: 345.0, trackAuthor: nil, trackImage: UIImage(named: "album5")!),
                                       MusicModel(trackName: "Antravor", trackTime: 280.0, trackAuthor: nil, trackImage: UIImage(named: "album6")!)]
    
    let trackName: String
    let trackTime: Double
    let trackAuthor: String?
    let trackImage: UIImage
    var isLoved: Bool = false
    
    init(trackName: String, trackTime: Double, trackAuthor: String?, trackImage: UIImage) {
        self.trackName = trackName
        self.trackTime = trackTime
        self.trackAuthor = trackAuthor
        self.trackImage = trackImage
    }
    

}
