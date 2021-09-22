//
//  HomeSectionHeaderView.swift
//  Music Bag
//
//  Created by Premier on 20/09/21.
//

import UIKit

class HomeSectionHeaderView: UIView {
    
    var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black17181A
        setupHeaderLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHeaderView(title: String) {
        self.title.text = title
    }
    
    private func setupHeaderLayout() {
        self.addSubview(title)
        title.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
}
