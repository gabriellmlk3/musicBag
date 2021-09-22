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
        
    var musics: [MusicModel]? {
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
        self.musics = musics
    }

}
