//
//  HomeViewController.swift
//  Music Bag
//
//  Created by Premier on 16/09/21.
//

import UIKit

class HomeViewController: BaseViewController, HomeViewModelDelegate {
    func loadDataDidFinish() {
    }
    
    func loadDataDidFinish(with error: String) {
    }
    
    
    private lazy var viewModel = HomeViewModel(delegate: self)
    
    private var hasLovedTrack: [MusicModel]?
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .black17181A
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupView()
        self.setNormalNavigationController(title: "Musics")
        self.viewModel.fetchMusics(musics: MusicModel.shared)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    
    private func setupView() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let musics = viewModel.musics else { return 0 }
        return musics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeTableViewCell,
              let musics = viewModel.musics else { return UITableViewCell() }
        
        cell.setupCell(music: musics[indexPath.row])
        
        if musics[indexPath.row].isLoved && indexPath.section == 0 {
            return cell
        } else {
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let musics = viewModel.musics else { return }
        let viewController = MusicViewController(music: musics[indexPath.row])
        viewController.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}
