//
//  TableViewCell.swift
//  Music Bag
//
//  Created by Premier on 06/08/21.
//

import UIKit

final class HomeTableViewCell: UITableViewCell {
    
    static let reuseID = "HomeCell"
    
    private var musicID: String = String()
    
    private var isLoved: Bool = false
    
    private let musicImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private var isLovedIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.image = UIImage.filledHeartCircleIcon
        return imageView
    }()
    
    private var isPlayingIndicator: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.image = .playIcon
        return imageView
    }()
    
    private var divisor: UIView = {
        let view = UIView()
        view.backgroundColor = .gray383838
        return view
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
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(80)
        }
        
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(musicImage.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-15)
        }
        
        self.addSubview(authorNameLabel)
        authorNameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.leading.equalTo(titleLabel)
            make.bottom.equalToSuperview().offset(-20)
        }
        
        if MusicManager.shared.lovedMusicID.contains(musicID){
            self.addSubview(isLovedIndicator)
            isLovedIndicator.snp.makeConstraints { make in
                make.trailing.equalToSuperview().offset(-15)
                make.centerY.equalToSuperview()
                make.height.equalTo(20)
                make.width.equalTo(25)
            }
        } else {
            isLovedIndicator.removeFromSuperview()
        }
        
        if  MusicManager.shared.hasPlayingMusic && MusicManager.shared.musicID == musicID {
            self.addSubview(isPlayingIndicator)
            isPlayingIndicator.snp.makeConstraints { make in
                make.trailing.equalTo(MusicManager.shared.playingMusic?.isLoved ?? false ? isLovedIndicator.snp.leading : self).offset(-15)
                make.centerY.equalToSuperview()
                make.height.equalTo(20)
                make.width.equalTo(20)
                
            }
        } else {
            isPlayingIndicator.removeFromSuperview()
        }
        
        self.addSubview(divisor)
        divisor.snp.makeConstraints { make in
            make.leading.equalTo(musicImage.snp.trailing)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    func setupCell(music: MusicModel) {
        setupLayout()
        self.titleLabel.text = music.trackName
        self.authorNameLabel.text = music.trackAuthor
        self.musicImage.kf.setImage(with: URL(string: music.trackImage))
        self.musicID = music.trackID
        self.isLoved = music.isLoved
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

