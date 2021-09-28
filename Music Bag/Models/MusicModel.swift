//
//  MusicModel.swift
//  Music Bag
//
//  Created by Premier on 17/09/21.
//

import UIKit

class MusicModel {
    static var shared: [MusicModel] = [
//        MusicModel(trackName: "-", trackTime: 320.0, trackAuthor: nil, trackImage: UIImage(named: "album")!),
//        MusicModel(trackName: "Why", trackTime: 345.0, trackAuthor: "Roy Woods", trackImage: UIImage(named: "album2")!),
//        MusicModel(trackName: "Distance", trackTime: 280.0, trackAuthor: "OneRepublic Human", trackImage: UIImage(named: "album3")!),
//        MusicModel(trackName: "Plastic Hearts", trackTime: 320.0, trackAuthor: "Miley Cyrus", trackImage: UIImage(named: "album4")!),
//        MusicModel(trackName: "-", trackTime: 345.0, trackAuthor: nil, trackImage: UIImage(named: "album5")!),
//        MusicModel(trackName: "BOYFRIEND", trackTime: 280.0, trackAuthor: "Tyler, The Creator", trackImage: UIImage(named: "album6")!),
//        MusicModel(trackName: "Wolf", trackTime: 280.0, trackAuthor: "David Getta", trackImage: UIImage(named: "album7")!),
        MusicModel(trackName: "Churrasco de Band", trackTime: 280.0, trackAuthor: "MC PP da VS (DJ Oreia)", trackImage: UIImage(named: "album9")!, trackURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/pure-environs-322118.appspot.com/o/Churrasco%20de%20Band%20-%20MC%20PP%20da%20VS%20(DJ%20Oreia)_160k.mp3?alt=media&token=74e8158b-24d5-48d8-9839-c10eb8c9c440")),
        MusicModel(trackName: "Starboy ft. Daft Punk", trackTime: 200.0, trackAuthor: "The Weekend", trackImage: UIImage(named: "album8")!, trackURL: URL(string: "https://firebasestorage.googleapis.com/v0/b/pure-environs-322118.appspot.com/o/The%20Weeknd%20-%20Starboy%20(Audio)_160k.mp3?alt=media&token=2ce6578c-fe21-4eb9-bf89-782ac05e43b3"))
    ]
    
    let trackName: String
    let trackTime: Double
    let trackAuthor: String?
    let trackImage: UIImage
    let trackID: String
    let trackURL: URL?
    var isLoved: Bool = false
    
    init(trackName: String, trackTime: Double, trackAuthor: String?, trackImage: UIImage, trackURL: URL? = nil) {
        self.trackName = trackName
        self.trackTime = trackTime
        self.trackAuthor = trackAuthor == nil || trackAuthor == "" ? "Unknow" : trackAuthor
        self.trackImage = trackImage
        self.trackID = UUID().uuidString
        self.trackURL = trackURL
        print("MusicID ---- \(self.trackID)")
    }
    

}
