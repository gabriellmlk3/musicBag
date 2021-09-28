//
//  MusicManager.swift
//  Music Bag
//
//  Created by Premier on 27/09/21.
//

import Foundation
import AVFoundation

protocol MusicManagerDelegate {
    func refresh()
}

class MusicManager {
    
    static var shared = MusicManager()
    
    private var delegate: MusicManagerDelegate?
    
    var lovedMusicID: [String] = []
    var isLoved: Bool = false {
        didSet {
            delegate?.refresh()
        }
    }
    var isPlaying: Bool = false {
        didSet {
            delegate?.refresh()
        }
    }
    var musicID: String?
    var player: AVAudioPlayer?
    var playedViewController: MusicViewController?
    
    func setDelegate(delegate: MusicManagerDelegate) {
        self.delegate = delegate
    }
}
