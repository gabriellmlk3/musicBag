//
//  NoPlayingMusicViewController.swift
//  Music Bag
//
//  Created by Premier on 27/09/21.
//

import UIKit

class NoPlayingMusicViewController: UIViewController {
    
    private var hasNoPlayimMusicLabel: UILabel = {
        let label = UILabel()
        label.text = "Has no playin music"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupLabel()
    }
    
    private func setupLabel() {
        view.addSubview(hasNoPlayimMusicLabel)
        hasNoPlayimMusicLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

}
