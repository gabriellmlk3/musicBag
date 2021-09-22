//
//  TableViewCell.swift
//  Music Bag
//
//  Created by Premier on 06/08/21.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {
    
    static let reuseID = "HomeCell"
    
    private let musicImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .gray
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private var isLovedIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: HomeTableViewCell.reuseID)
        self.backgroundColor = .black1E2125
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout() {
        
        self.addSubview(musicImage)
        musicImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
            make.size.equalTo(80)
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(musicImage.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(isLovedIndicator)
        isLovedIndicator.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.size.equalTo(30)
        }
    }
    
    func setupCell(music: MusicModel) {
        setupLayout()
        self.isLovedIndicator.image = music.isLoved ? UIImage.filledHeartCircleIcon : UIImage()
        self.titleLabel.text = music.trackName
        self.musicImage.image = music.trackImage
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
