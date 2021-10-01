//
//  HomeViewController.swift
//  Music Bag
//
//  Created by Premier on 16/09/21.
//

import UIKit

class HomeViewController: BaseViewController {
    
    private lazy var viewModel = HomeViewModel(delegate: self)
    
    private var hasLovedTrack: [MusicModel]?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private var segmentControll: UISegmentedControl = {
        let segmentControll = UISegmentedControl()
        segmentControll.layer.cornerRadius = 0
        segmentControll.selectedSegmentIndex = 0
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
//        self.showLoad(view: self)
        view.backgroundColor = .backgroundColor
        setupView()
        MusicManager.shared.setDelegate(delegate: self)
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let musics = viewModel.musics[section] else { return 0 }
        let lovedMusics = MusicManager.shared.lovedMusicID
        
        if section == 0 {
            return lovedMusics.count
        } else {
            return musics.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeTableViewCell,
              let music = viewModel.musics[indexPath.section]?[indexPath.row] else { return UITableViewCell() }
        let view = UIView()
        view.backgroundColor = .black101112
        cell.selectedBackgroundView = view
        cell.setupCell(music: music)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let music = viewModel.musics[indexPath.section]?[indexPath.row] else { return }
        var viewController = MusicViewController(music: music)
        if MusicManager.shared.musicID == music.trackID {
            guard let musicViewController = MusicManager.shared.playedViewController else { return }
            viewController = musicViewController
        } else {
            viewController = MusicViewController(music: music)
        }
        viewController.modalPresentationStyle = .automatic
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.present(viewController, animated: true)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    
    func loadDataDidFinish() {
        tableView.reloadData()
    }
    
    func loadDataDidFinish(with error: String) {
        self.showAlert(text: error)
    }
}

extension HomeViewController: MusicManagerDelegate {
    func refresh() {
        tableView.reloadData()
    }
    
}

