//
//  MusicManager.swift
//  Music Bag
//
//  Created by Premier on 27/09/21.
//

import Foundation
import AVFoundation

protocol MusicManagerDelegate: AnyObject {
    func update(subject: MusicManager)
}

class MusicManager {
    
    static var shared = MusicManager()
    private(set) var musics: [MusicModel] = []
    private var delegates: [MusicManagerDelegate] = []
    private(set) var playingMusic: MusicModel?
    
    var player: AVAudioPlayer?
    var musicID: String?
    var lovedMusicID: [String] = []
    var lastPlayedViewController: MusicViewController?
    
    var hasPlayingMusic: Bool = false {
        didSet {
            print("Music Manager: hasPlayingMusic has changed to \(hasPlayingMusic)\n")
            self.notify()
        }
    }
    
    var currentTime: Double {
        get {
            return Double(player?.currentTime ?? 0)
        }
        
        set {
            self.player?.currentTime = newValue
        }
    }
    
    var totalTime: Double {
        get {
            return Double(player?.duration ?? 0)
        }
    }
    
    init() {
        print("-/-/-/-/-/ MUSIC MANAGER INITIED /-/-/-/-/-")
        print("Music Manager: Loading data...")
        self.fulfillData { musics in
            self.musics = musics
            print("Music Manager: Data successfuly loaded")
            self.notify()
        }
    }
    
}

//MARK: - Audio Control
extension MusicManager {
    
    func play() {
        self.player?.play()
    }
    
    func pause() {
        self.player?.pause()
    }
    
    func stop() {
        self.player?.stop()
    }
    
    func fetchMusics(music: MusicModel) {
        self.playingMusic = music
        
        if let trackURL = music.trackURL {
            guard let url = URL(string: trackURL) else { return }
            
            checkBookFileExists(withLink: url) { [weak self] downloadedURL in
                guard let self = self else{ return }
                self.prepareToPlay(url: downloadedURL)
                self.notify()
            }
        }
    }
    
    private func checkBookFileExists(withLink url: URL, completion: @escaping ((_ filePath: URL)->Void)){
        
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
    
    private func prepareToPlay(url: URL) {
        do {
            if self.playingMusic?.trackID == MusicManager.shared.musicID {
                self.player = MusicManager.shared.player
            } else {
                self.player = try AVAudioPlayer(contentsOf: url)
            }
            MusicManager.shared.player = player
            self.player?.prepareToPlay()
        } catch {
            player = nil
        }
    }
    
    private func downloadFile(withUrl url: URL, andFilePath filePath: URL, completion: @escaping ((_ filePath: URL)->Void)){
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try Data.init(contentsOf: url)
                try data.write(to: filePath, options: .atomic)
                print("Music Manager: saved at \(filePath.absoluteString)")
                DispatchQueue.main.async {
                    completion(filePath)
                }
            } catch {
                print("Music Manager: an error happened while downloading or saving the file")
            }
        }
    }
}

//MARK: - Observer Management
extension MusicManager {
    
    func attach(_ observer: MusicManagerDelegate) {
        self.delegates.append(observer)
        print("Music Manager: Observer - \(observer) - Attached\n")
    }
    
    func detach(_ observer: MusicManagerDelegate) {
        if let index = delegates.firstIndex(where: { $0 === observer }) {
            delegates.remove(at: index)
            print("Music Manager: Observer - \(observer) - Dettached\n")
        }
    }
    
    func notify() {
        print("Music Manager: Notifying observers...")
        delegates.forEach({
            $0.update(subject: self)
            print("Music Manager: Observer - \($0) - notifyed\n")
        })
    }
    
}

//MARK: - Data Controll
extension MusicManager {
    
    private func fulfillData(completion: @escaping([MusicModel]) -> Void) {
        FireBaseManager.shared.readFromFirestore(collection: "Music", completion: { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let documents):
                
                var musics: [MusicModel] = []
                
                for document in documents {
                    
                    let documentData = document.data()
                    let trackName = documentData["track_name"] as? String ?? ""
                    let trackAuthor = documentData["track_author"] as? String ?? ""
                    let trackImage = documentData["track_image"] as? String ?? ""
                    let trackURL = documentData["track_url"] as? String ?? ""
                    let trackID = document.documentID
                    
                    let music = MusicModel(trackName: trackName,
                                           trackAuthor: trackAuthor,
                                           trackImage: trackImage,
                                           trackURL: trackURL,
                                           trackID: trackID)
                    
                    musics.append(music)
                }
                
                completion(musics)
            }
        })
    }
    
}
