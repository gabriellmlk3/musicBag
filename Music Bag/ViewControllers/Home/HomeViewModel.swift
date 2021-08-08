//
//  HomeViewModel.swift
//  Music Bag
//
//  Created by Premier on 06/08/21.
//

import Foundation

protocol HomeViewModelDelegate {
    func loadDataDidFinish()
    func loadDataDidFinish(with error: String)
}

class HomeViewModel {
    
    var dataSource: VideoModel? {
        didSet {
            delegate.loadDataDidFinish()
        }
    }
    
    private var delegate: HomeViewModelDelegate
    
    init(delegate: HomeViewModelDelegate){
        self.delegate = delegate
        self.loadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadData() {
        NetworkManager.shared.fetch(VideoModel.self, endpoint: .youTube) { result in
            switch result {
            case .success(let video):
                self.dataSource = video
                debugPrint(video)
            case .failure(let error):
                self.delegate.loadDataDidFinish(with: error.localizedDescription)
                print("fail: \(error)")
            }
        }
    }
}
