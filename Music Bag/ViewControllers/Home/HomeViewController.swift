//
//  HomeViewController.swift
//  Music Bag
//
//  Created by Premier on 16/09/21.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private var hasLovedTrack: [MusicModel]?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private var segmentControll: UISegmentedControl = {
        let segmentControll = UISegmentedControl()
        segmentControll.layer.cornerRadius = 0
        segmentControll.insertSegment(withTitle: "Musics", at: 0, animated: true)
        segmentControll.insertSegment(withTitle: "Loved", at: 1, animated: true)
        segmentControll.selectedSegmentTintColor = .gray
        segmentControll.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold),
                                                NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        return segmentControll
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .backgroundColor
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupView()
        self.showLoad()
        MusicManager.shared.attach(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    private func setupView() {
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        scrollView.addSubview(segmentControll)
        segmentControll.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view)
            make.height.equalTo(45)
        }
        
        scrollView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentControll.snp.bottom)
            make.leading.trailing.equalTo(view)
            make.bottom.equalTo(view).offset(-100)
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MusicManager.shared.musics.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        let music = MusicManager.shared.musics[indexPath.row]
        let musicCount = MusicManager.shared.musics.count
        
        if indexPath.row == musicCount - 1 {
            let bezierPath = UIBezierPath(rect: CGRect(x: 0, y: cell.bounds.height / 2, width: cell.bounds.width, height: cell.bounds.height / 2))
            cell.addShadow(shadowOpacity: 0.6, shadowRadius: 5, with: bezierPath)
        }
        
        let view = UIView()
        view.backgroundColor = .black101112
        cell.selectedBackgroundView = view
        cell.setupCell(music: music)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let music = MusicManager.shared.musics[indexPath.row]
        var viewController: UIViewController
        if MusicManager.shared.musicID == music.trackID {
            guard let musicViewController = MusicManager.shared.lastPlayedViewController else { return }
            viewController = musicViewController
        } else {
            viewController = MusicViewController(music: music)
        }
        viewController.modalPresentationStyle = .automatic
        viewController.hidesBottomBarWhenPushed = true
        
        if FireBaseManager.shared.auth.currentUser != nil {
            self.navigationController?.present(viewController, animated: true)
        } else {
            self.showAlert(text: "You must be logged")
        }
        
    }
}

extension HomeViewController: MusicManagerDelegate {

    func update(subject: MusicManager) {
        self.dismissLoad()
        tableView.reloadData()
    }
    
}

