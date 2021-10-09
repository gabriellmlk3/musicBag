//
//  ProfileMenuButton.swift
//  Music Bag
//
//  Created by Premier on 09/10/21.
//

import UIKit

class ProfileMenuButton: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        return imageView
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .none
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    init(title: String, icon: UIImage, target: Any?, action: Selector) {
        super.init(frame: .zero)
        self.imageView.image = icon
        self.button.setAttributedTitle(NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold)]), for: .normal)
        self.button.addTarget(target, action: action, for: .touchUpInside)
        setupButonView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButonView() {
        self.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        self.addSubview(button)
        button.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(20)
        }
    }
    
}
