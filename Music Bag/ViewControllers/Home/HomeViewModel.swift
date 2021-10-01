//
//  HomeViewModel.swift
//  Music Bag
//
//  Created by Premier on 20/09/21.
//

import Foundation

protocol HomeViewModelDelegate {
    func loadDataDidFinish()
    func loadDataDidFinish(with error: String)
}

class HomeViewModel {
    
    var dataSource: [MusicModel] = []
    
    var musics: Dictionary = [Int: [MusicModel]]() {
        didSet {
            self.delegate.loadDataDidFinish()
        }
    }
    
    private var delegate: HomeViewModelDelegate
    
    init(delegate: HomeViewModelDelegate){
        self.delegate = delegate
        self.fulfillData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchMusics(musics: [MusicModel]) {
        self.dataSource = musics
        self.populateDictionary()
    }
    
    private func populateDictionary() {
        self.musics = Dictionary(grouping: dataSource, by: {
                                    switch $0.isLoved {
                                    case true:
                                        return 0
                                    case false:
                                        return 1
                                    }
            
        })
    }
    
    private func fulfillData() {
        FireBaseManager.shared.readFromFirestore(collection: "Music", completion: { result in
            switch result {
            case .failure(let error):
                self.delegate.loadDataDidFinish(with: error.localizedDescription)
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
                
                self.fetchMusics(musics: musics)
            }
        })
    }

}
