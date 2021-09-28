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
            delegate.loadDataDidFinish()
        }
    }
    
    private var delegate: HomeViewModelDelegate
    
    init(delegate: HomeViewModelDelegate){
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchMusics(musics: [MusicModel]) {
        self.dataSource = musics
        populateDictionary()
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

}
