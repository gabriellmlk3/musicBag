//
//  ViewController.swift
//  Music Bag
//
//  Created by Premier on 06/08/21.
//

import UIKit
import AVFoundation

class MusicViewController: BaseViewController, UIScrollViewDelegate {
    
//MARK: - Attributes
    private var isPlaying: Bool {
        didSet {
            if self.isPlaying {
                self.playPauseButton.setImage(.pauseIcon, for: .normal)
            } else {
                self.playPauseButton.setImage(.playIcon, for: .normal)
            }
        }
    }
    
    private var timer: Timer?
    private var totalTime = 0.0
    private var time = 0.0
    private var player: AVAudioPlayer?

    private lazy var viewModel = MusicViewModel(delegate: self)
    
    private lazy var whiteGradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = CGSize(width: view.bounds.size.width, height: view.bounds.size.height * 0.15)
        gradientLayer.colors = UIColor.CGBlackScaleTopDown
        return gradientLayer
    }()
    
    private lazy var whiteGradientView: UIView = {
        let view = UIView()
        view.layer.addSublayer(whiteGradientLayer)
        return view
    }()
    
    private lazy var blackGradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = CGSize(width: view.bounds.size.width, height: view.bounds.size.height * 0.15)
        gradientLayer.colors = UIColor.CGBlackScaleDownTop
        return gradientLayer
    }()
    
    private lazy var blackGradientView: UIView = {
        let view = UIView()
        view.layer.addSublayer(blackGradientLayer)
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
    
    private var imageContainerHeaderView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
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
        view.backgroundColor = .black17181A
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
    
    private var trackTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00:00"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    private lazy var progressSlider: UISlider = {
        let slider = UISlider()
        let thumbImage = UIImage.circlebadgeIcon.cgImage
        slider.maximumValue = Float(totalTime)
        slider.isContinuous = true
        slider.tintColor = .blue505975
        slider.addTarget(self, action: #selector(changeTimeWithSlider), for: .valueChanged)
        slider.setThumbImage(UIImage(cgImage: thumbImage!, scale: 2, orientation: .down) , for: .normal)
        return slider
    }()
    
    private var playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(.playIcon, for: .normal)
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
        guard let music = viewModel.music else { return buttonItem }
        buttonItem.setImage(music.isLoved ? .filledHeartCircleIcon : .heartCircleIcon, for: .normal)
        buttonItem.addTarget(self, action: #selector(toggleLoveButton), for: .touchUpInside)
        buttonItem.tintColor = music.isLoved ? .pinkC700B0 : .white
        return buttonItem
    }()
    
    
    //MARK: - Initializers
    init(music: MusicModel) {
        self.isPlaying = false
        super.init(nibName: nil, bundle: nil)
        self.startTimer(totalTimeInSeconds: music.trackTime)
        self.trackNameLabel.text = music.trackName
        self.imageView.image = music.trackImage
        self.greaterImageView.image = music.trackImage
        self.viewModel.fetchMusics(music: music)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black101112
        self.setClearNavigationController()
        setupLayout()
    }
}

//MARK: - HomeViewDelegate
extension MusicViewController: MusicViewModelDelegate {
    func loadDataDidFinish() {
    }
    
    func loadDataDidFinish(with error: String) {
        DispatchQueue.main.async {
            self.showAlert(with: error)
        }
    }
}

//MARK: - Buttons Controller
extension MusicViewController {
    
    @objc
    private func updatePlayer() {
        if time < totalTime && isPlaying { time += 1 }
        if time == totalTime { isPlaying = false }
        if time < 0 { time = 0.0} else if time > totalTime { time = totalTime }
        
        trackTimeLabel.text = self.timeFormatted(Int(time))
        UIView.animate(withDuration: 0.9) {
            self.progressSlider.setValue(Float(self.time), animated: true)
        }
    }
    
    @objc
    private func backwardTrack() {
        time = 0.0
        updatePlayer()
    }
    
    @objc
    private func forwardTrack() {
        time = totalTime
        updatePlayer()
    }
    
    @objc
    private func backward5SecTrack() {
        if time > 0 { time -= 5.0 }
        updatePlayer()
    }
    
    @objc
    private func forward5SecTrack() {
        if time < totalTime { time += 5.0 }
        updatePlayer()
    }
    
    @objc
    private func togglePlayPause() {
        isPlaying.toggle()
    }
    
}

//MARK: - Timer Controller
extension MusicViewController {
    
    private func startTimer(totalTimeInSeconds: Double) {
        self.totalTime = totalTimeInSeconds
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatePlayer), userInfo: nil, repeats: true)
    }
    
    private func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        let hours: Int = (totalSeconds / 60) / 60
        return String(format: "%02d:%02d:%02d", hours ,minutes, seconds)
    }
    
}

extension MusicViewController {
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "soundName", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

            guard let player = player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc
    private func changeTimeWithSlider() {
        time = Double(progressSlider.value)
    }
    
    @objc
    private func toggleLoveButton() {
        guard let music = viewModel.music else { return }
        if music.isLoved {
            self.loveButtonItem.tintColor = .white
            self.loveButtonItem.setImage(UIImage.heartCircleIcon, for: .normal)
            music.isLoved = false
        } else {
            self.loveButtonItem.tintColor = .pinkC700B0
            self.loveButtonItem.setImage(UIImage.filledHeartCircleIcon, for: .normal)
            music.isLoved = true
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
            
            blurVisualEffectView.contentView.addSubview(imageContainerHeaderView)
            imageContainerHeaderView.snp.makeConstraints { make in
                make.centerY.equalTo(blurVisualEffectView).offset(-100)
                make.leading.equalToSuperview().offset(5)
                make.trailing.equalToSuperview().offset(-5)
                make.height.equalTo(400)
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
            
            scrollView.addSubview(loveButtonItem)
            loveButtonItem.snp.makeConstraints { make in
                make.top.equalTo(imageContainerHeaderView.snp.bottom).offset(20)
                make.centerX.equalToSuperview()
            }
            
            scrollView.addSubview(whiteGradientView)
            whiteGradientView.snp.makeConstraints { make in
                make.top.equalTo(view)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(view.bounds.size.height * 0.15)
            }
            
            scrollView.addSubview(blackGradientView)
            blackGradientView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.bottom.equalTo(view).offset(-234)
                make.height.equalTo(view.bounds.size.height * 0.15)
            }
            
            scrollView.addSubview(contentContainerView)
            contentContainerView.snp.makeConstraints { make in
                make.top.equalTo(greaterImageContainerHeaderView.snp.bottom).offset(-16)
                make.leading.trailing.equalTo(view)
                make.bottom.equalTo(view)
                make.height.equalTo(250)
            }
            
            contentContainerView.addSubview(trackNameLabel)
            trackNameLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(20)
                make.leading.equalToSuperview().offset(15)
                make.trailing.equalToSuperview().offset(-15)
            }
            
            contentContainerView.addSubview(progressSlider)
            progressSlider.snp.makeConstraints { make in
                make.top.equalTo(trackNameLabel.snp.bottom).offset(15)
                make.leading.trailing.equalToSuperview()
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
            
            playerConteiner.addSubview(trackTimeLabel)
            trackTimeLabel.snp.makeConstraints { make in
                make.bottom.equalTo(playerConteiner.snp.top).offset(-5)
                make.leading.equalToSuperview().offset(10)
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
