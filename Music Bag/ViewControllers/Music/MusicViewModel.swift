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
    func loadDataDidFinish()
    func loadDataDidFinish(with error: String)
}

class MusicViewModel {
    
    var music: MusicModel? {
        didSet {
            delegate.loadDataDidFinish()
        }
    }
    
    private var delegate: MusicViewModelDelegate
    
    init(delegate: MusicViewModelDelegate){
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fetchMusics(music: MusicModel) {
        self.music = music
    }
    
}
