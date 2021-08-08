//
//  ViewController.swift
//  Music Bag
//
//  Created by Premier on 06/08/21.
//

import UIKit
import Alamofire

class HomeViewController: UIViewController {
    
    private lazy var viewModel = HomeViewModel(delegate: self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.reuseID)
        tableView.rowHeight = 80
        tableView.delegate = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        guard let dataCount = viewModel.dataSource?.items.count else { return }
        setupView()
    }
    
    private func setupView() {
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataCount = viewModel.dataSource?.items.count else { return 0 }
        return dataCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.reuseID, for: indexPath) as? HomeTableViewCell else { return UITableViewCell()}
        guard let video = viewModel.dataSource?.items[indexPath.row] else { return cell }
        cell.setupCell(item: video)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = VideoViewController()
        navigationController?.pushViewController(view, animated: true)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func loadDataDidFinish() {
    }
    
    func loadDataDidFinish(with error: String) {
        
    }
}

