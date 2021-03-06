//
//  ViewController.swift
//  Music Bag
//
//  Created by Premier on 06/08/21.
//

import UIKit
import AVFoundation
import Kingfisher

class MusicViewController: BaseViewController, UIScrollViewDelegate {
    
//MARK: - Attributes
    private var lastTitle = String()
    private var lastLargeTitle = true
    
    private var isPlaying = false {
        didSet {
            if self.isPlaying {
                self.playPauseButton.setImage(.pauseIcon, for: .normal)
                MusicManager.shared.play()
                MusicManager.shared.lastPlayedViewController = self
                MusicManager.shared.musicID = MusicManager.shared.playingMusic?.trackID
                if !MusicManager.shared.hasPlayingMusic {
                    MusicManager.shared.hasPlayingMusic = true
                }
            } else {
                self.playPauseButton.setImage(.playIcon, for: .normal)
                MusicManager.shared.pause()
                if MusicManager.shared.hasPlayingMusic {
                    MusicManager.shared.hasPlayingMusic = false
                }
            }
        }
    }
    
    private lazy var TopDownGradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = CGSize(width: view.bounds.size.width, height: view.bounds.size.height * 0.15)
        gradientLayer.colors = UIColor.CGBlackScaleTopDown
        return gradientLayer
    }()
    
    private lazy var TopDownGradientView: UIView = {
        let view = UIView()
        view.layer.addSublayer(TopDownGradientLayer)
        return view
    }()
    
    private lazy var DownTopGradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = CGSize(width: view.bounds.size.width, height: view.bounds.size.height * 0.15)
        gradientLayer.colors = UIColor.CGBlackScaleDownTop
        return gradientLayer
    }()
    
    private lazy var DownTopGradientView: UIView = {
        let view = UIView()
        view.layer.addSublayer(DownTopGradientLayer)
        return view
    }()
    
    private lazy var blurVisualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style:.systemChromeMaterialDark)
        let effectView = UIVisualEffectView(effect: blurEffect)
        return effectView
    }()
    
    private var greaterImageContainerHeaderView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    private var greaterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private var imageContainerHeaderShadowView: UIView = {
        let view = UIView()
        return view
    }()
    
    private var imageContainerHeaderView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        return scrollView
    }()
    
    private var contentContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        view.layer.cornerRadius = 16
        return view
    }()
    
    private var trackNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private var playerConteiner: UIView = {
        let view = UIView()
        view.backgroundColor = .black1E2125
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var trackCurrentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = MusicManager.shared.totalTime >= 3600 ? "00:00:00" : "00:00"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var trackRemainingTimeLabel: UILabel = {
        let label = UILabel()
        label.text = MusicManager.shared.totalTime >= 3600 ? "00:00:00" : "00:00"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var progressSlider: UISlider = {
        let slider = UISlider()
        let thumbImage = UIImage.circlebadgeIcon.cgImage
        slider.isContinuous = true
        slider.tintColor = .blue505975
        slider.addTarget(self, action: #selector(changeTimeWithSlider), for: .valueChanged)
        slider.setThumbImage(UIImage(cgImage: thumbImage!, scale: 2, orientation: .down) , for: .normal)
        return slider
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private var playPauseButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleToFill
        button.setImage(.playIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(togglePlayPause), for: .touchUpInside)
        return button
    }()
    
    private var forwardButton: UIButton = {
        let button = UIButton()
        button.setImage(.forwardIcon, for: .normal)
        button.addTarget(self, action: #selector(forwardTrack), for: .touchUpInside)
        return button
    }()
    
    private var forward5SecButton: UIButton = {
        let button = UIButton()
        button.setImage(.forward5SecIcon, for: .normal)
        button.addTarget(self, action: #selector(forward5SecTrack), for: .touchUpInside)
        return button
    }()
    
    private var backwardButton: UIButton = {
        let button = UIButton()
        button.setImage(.backwardIcon, for: .normal)
        button.addTarget(self, action: #selector(backwardTrack), for: .touchUpInside)
        return button
    }()
    
    private var backward5SecButton: UIButton = {
        let button = UIButton()
        button.setImage(.backward5SecIcon, for: .normal)
        button.addTarget(self, action: #selector(backward5SecTrack), for: .touchUpInside)
        return button
    }()
    
    private lazy var loveButtonItem: UIButton = {
        let buttonItem = UIButton()
        guard let music = MusicManager.shared.playingMusic else { return buttonItem }
        buttonItem.setImage(music.isLoved ? .filledHeartCircleIcon : .heartCircleIcon, for: .normal)
        buttonItem.addTarget(self, action: #selector(toggleLoveButton), for: .touchUpInside)
        buttonItem.tintColor = music.isLoved ? .systemRed : .white
        buttonItem.imageView?.clipsToBounds = false
        buttonItem.imageView?.addShadow(shadowOpacity: 1, shadowRadius: 5)
        return buttonItem
    }()
    
    //MARK: - Initializers
    init(music: MusicModel) {
        super.init(nibName: nil, bundle: nil)
        MusicManager.shared.fetchMusics(music: music)
        self.progressSlider.maximumValue = Float(MusicManager.shared.totalTime)
        self.trackNameLabel.text = music.trackName
        self.authorNameLabel.text = music.trackAuthor
        self.imageView.kf.setImage(with: URL(string: music.trackImage))
        self.greaterImageView.kf.setImage(with: URL(string: music.trackImage))
    }
    
    deinit {
        print("Music Deinited")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.backBarButtonItem = UIBarButtonItem(image: .backArrowIcon, style: .plain, target: nil, action: nil)
        view.backgroundColor = .black101112
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTrack), userInfo: .none, repeats: true)
        setupLayout()
    }
}

//MARK: - Buttons Controller
extension MusicViewController {
    
    @objc
    private func updateTrack() {
        var currentTime = MusicManager.shared.currentTime
        if currentTime == 0 {
            isPlaying = false
        }
        if currentTime < 0 {
            currentTime = 0.0
        } else if currentTime > MusicManager.shared.totalTime {
            currentTime = MusicManager.shared.totalTime
        }
        
        trackCurrentTimeLabel.text = self.timeFormatted(Int(currentTime))
        trackRemainingTimeLabel.text = self.timeFormatted(Int(MusicManager.shared.totalTime - currentTime))
        
        UIView.animate(withDuration: 0.9) {
            self.progressSlider.setValue(Float(currentTime), animated: true)
        }
    }
    
    @objc
    private func backwardTrack() {
        MusicManager.shared.player?.currentTime = 0.0
        updateTrack()
    }
    
    @objc
    private func forwardTrack() {
        MusicManager.shared.player?.currentTime = MusicManager.shared.totalTime
        updateTrack()
    }
    
    @objc
    private func backward5SecTrack() {
        guard let currentTime = MusicManager.shared.player?.currentTime else { return }
        if currentTime > 0 {
            MusicManager.shared.player?.currentTime -= 5.0
        }
        updateTrack()
    }
    
    @objc
    private func forward5SecTrack() {
        if MusicManager.shared.currentTime < MusicManager.shared.totalTime { MusicManager.shared.player?.currentTime += 5.0 }
        updateTrack()
    }
    
    @objc
    private func togglePlayPause() {
        isPlaying.toggle()
    }
    
}

//MARK: - Timer Controller
extension MusicViewController {
    
    private func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        let hours: Int = (totalSeconds / 60) / 60
        
        if MusicManager.shared.totalTime >= 3600 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
}

extension MusicViewController {
    
    @objc
    private func changeTimeWithSlider() {
        MusicManager.shared.player?.currentTime = TimeInterval(progressSlider.value)
    }
    
    @objc
    private func toggleLoveButton() {
        guard let music = MusicManager.shared.playingMusic else { return }
        if music.isLoved {
            self.loveButtonItem.tintColor = .white
            self.loveButtonItem.setImage(UIImage.heartCircleIcon, for: .normal)
            music.isLoved = false
            guard let index = MusicManager.shared.lovedMusicID.firstIndex(of: music.trackID) else { return }
            MusicManager.shared.lovedMusicID.remove(at: index)
            MusicManager.shared.playingMusic?.isLoved = false
        } else {
            self.loveButtonItem.tintColor = .systemRed
            self.loveButtonItem.setImage(UIImage.filledHeartCircleIcon, for: .normal)
            music.isLoved = true
            MusicManager.shared.lovedMusicID.append(music.trackID)
            MusicManager.shared.playingMusic?.isLoved = true
        }
    }
}

extension MusicViewController {
    
    //MARK: - Layout
        private func setupLayout() {
            view.addSubview(greaterImageContainerHeaderView)
            greaterImageContainerHeaderView.snp.makeConstraints { make in
                make.top.equalToSuperview()
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
            
            greaterImageContainerHeaderView.addSubview(greaterImageView)
            greaterImageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            view.addSubview(blurVisualEffectView)
            blurVisualEffectView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            blurVisualEffectView.contentView.addSubview(imageContainerHeaderShadowView)
            imageContainerHeaderShadowView.snp.makeConstraints { make in
                make.centerY.equalTo(blurVisualEffectView).offset(-100)
                make.leading.equalToSuperview().offset(5)
                make.trailing.equalToSuperview().offset(-5)
                make.height.equalTo(400)
            }
            
            imageContainerHeaderShadowView.addSubview(imageContainerHeaderView)
            imageContainerHeaderView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            imageContainerHeaderView.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            view.addSubview(scrollView)
            scrollView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
                make.width.equalTo(view.bounds.width)
            }
            
            if FireBaseManager.shared.auth.currentUser != nil {
                scrollView.addSubview(loveButtonItem)
                loveButtonItem.snp.makeConstraints { make in
                    make.top.equalTo(imageContainerHeaderView.snp.bottom).offset(20)
                    make.centerX.equalToSuperview()
                }
            }
            
            scrollView.addSubview(TopDownGradientView)
            TopDownGradientView.snp.makeConstraints { make in
                make.top.equalTo(view)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(view.bounds.size.height * 0.15)
            }
            
            scrollView.addSubview(DownTopGradientView)
            DownTopGradientView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(view).offset(-234)
                make.height.equalTo(view.bounds.size.height * 0.15)
            }
            
            scrollView.addSubview(contentContainerView)
            contentContainerView.snp.makeConstraints { make in
                make.top.equalTo(greaterImageContainerHeaderView.snp.bottom).offset(-16)
                make.leading.trailing.equalTo(view)
                make.bottom.equalTo(view)
                make.height.equalTo(view.bounds.height / 100 * 28)
            }
            
            contentContainerView.addSubview(trackNameLabel)
            trackNameLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(15)
                make.leading.equalToSuperview().offset(15)
                make.trailing.equalToSuperview().offset(-15)
            }
            
            contentContainerView.addSubview(progressSlider)
            progressSlider.snp.makeConstraints { make in
                make.top.equalTo(trackNameLabel.snp.bottom).offset(10)
                make.leading.trailing.equalToSuperview()
            }
            
            contentContainerView.addSubview(authorNameLabel)
            authorNameLabel.snp.makeConstraints { make in
                make.top.equalTo(progressSlider.snp.bottom).offset(15)
                make.centerX.equalToSuperview()
            }
            
            contentContainerView.addSubview(playerConteiner)
            playerConteiner.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(20)
                make.trailing.equalToSuperview().offset(-20)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
                make.height.equalTo(60)
            }
            
            playerConteiner.addSubview(playPauseButton)
            playPauseButton.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.size.equalTo(30)
            }
            
            playerConteiner.addSubview(forward5SecButton)
            forward5SecButton.snp.makeConstraints { make in
                make.leading.equalTo(playPauseButton.snp.trailing).offset(45)
                make.centerY.equalTo(playPauseButton)
                make.height.equalTo(30)
                make.width.equalTo(25)
            }
            
            playerConteiner.addSubview(forwardButton)
            forwardButton.snp.makeConstraints { make in
                make.leading.equalTo(forward5SecButton.snp.trailing).offset(45)
                make.centerY.equalTo(playPauseButton)
                make.size.equalTo(20)
            }
            
            playerConteiner.addSubview(trackCurrentTimeLabel)
            trackCurrentTimeLabel.snp.makeConstraints { make in
                make.bottom.equalTo(playerConteiner.snp.top).offset(-5)
                make.leading.equalToSuperview().offset(10)
            }
            
            playerConteiner.addSubview(trackRemainingTimeLabel)
            trackRemainingTimeLabel.snp.makeConstraints { make in
                make.bottom.equalTo(playerConteiner.snp.top).offset(-5)
                make.trailing.equalToSuperview().offset(-10)
            }
            
            playerConteiner.addSubview(backward5SecButton)
            backward5SecButton.snp.makeConstraints { make in
                make.trailing.equalTo(playPauseButton.snp.leading).offset(-45)
                make.centerY.equalTo(playPauseButton)
                make.height.equalTo(30)
                make.width.equalTo(25)
            }
            
            playerConteiner.addSubview(backwardButton)
            backwardButton.snp.makeConstraints { make in
                make.trailing.equalTo(backward5SecButton.snp.leading).offset(-45)
                make.centerY.equalTo(playPauseButton)
                make.size.equalTo(20)
            }
        }
}
