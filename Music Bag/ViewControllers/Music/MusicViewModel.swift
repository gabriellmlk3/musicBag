//
//  HomeViewModel.swift
//  Music Bag
//
//  Created by Premier on 06/08/21.
//

import Foundation
import AVFoundation
import Firebase
import FirebaseStorage

protocol MusicViewModelDelegate {
    func updateSliderWithTotalTime()
    func updatePlayer()
    func loadDataDidFinish()
    func loadDataDidFinish(with error: String)
}

extension MusicViewModelDelegate {
    func updateSliderWithTotalTime() {}
    func updatePlayer() {}
    func loadDataDidFinish() {}
    func loadDataDidFinish(with error: String) {}
}

class MusicViewModel {
    
    static var shared = MusicViewModel()
    
    var music: MusicModel?
    
    var totalTime: TimeInterval = 0.0 {
        didSet{
            self.delegate?.updateSliderWithTotalTime()
        }
    }
    
    var CurrenTime: TimeInterval = 0.0 {
        didSet{
            self.delegate?.updatePlayer()
        }
    }
    var player: AVAudioPlayer?
    var trackFilePath: URL?
    
    private var delegate: MusicViewModelDelegate?
    
    func stop() {
        player?.stop()
    }
    
    func play() {
        player?.play()
    }
    
    func pause() {
        player?.pause()
    }
}

extension MusicViewModel {
    
    func fetchMusics(music: MusicModel?, delegate: MusicViewModelDelegate) {
        self.delegate = delegate
        self.music = music
        
        if let trackURL = music?.trackURL {
                checkBookFileExists(withLink: trackURL){ [weak self] downloadedURL in
                    guard let self = self else{
                        return
                    }
                    self.trackFilePath = downloadedURL
                    self.prepareToPlay(url: downloadedURL)
                    self.delegate?.loadDataDidFinish()
                }
            }
    }
    
    func prepareToPlay(url: URL) {
        do {
            if self.music?.trackID == MusicManager.shared.musicID {
                self.player = MusicManager.shared.player
            } else {
                self.player = try AVAudioPlayer(contentsOf: url)
            }
            MusicManager.shared.player = player
            self.player?.prepareToPlay()
            DispatchQueue.main.async {
                self.totalTime = self.player?.duration ?? 0
                self.CurrenTime = self.player?.currentTime ?? 0
            }
        } catch {
            player = nil
        }
    }
    
    func downloadFile(withUrl url: URL, andFilePath filePath: URL, completion: @escaping ((_ filePath: URL)->Void)){
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try Data.init(contentsOf: url)
                try data.write(to: filePath, options: .atomic)
                print("saved at \(filePath.absoluteString)")
                DispatchQueue.main.async {
                    completion(filePath)
                }
            } catch {
                print("an error happened while downloading or saving the file")
            }
        }
    }
    
    func checkBookFileExists(withLink url: URL, completion: @escaping ((_ filePath: URL)->Void)){
        
        let fileManager = FileManager.default
        if let documentDirectory = try? fileManager.url(for: .documentDirectory, in: .userDomainMask, appropriateFor:nil, create: false){
            
            let filePath = documentDirectory.appendingPathComponent(url.lastPathComponent, isDirectory: false)
            
            do {
                if try filePath.checkResourceIsReachable() {
                    completion(filePath)
                    
                } else {
                    downloadFile(withUrl: url, andFilePath: filePath, completion: completion)
                }
            } catch {
                downloadFile(withUrl: url, andFilePath: filePath, completion: completion)
            }
        }
    }
    
}
