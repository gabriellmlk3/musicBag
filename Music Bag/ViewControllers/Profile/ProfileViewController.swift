//
//  ProfileViewController.swift
//  Music Bag
//
//  Created by Premier on 28/09/21.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    private var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private var headerContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black1E2125
        return view
    }()
    
    private var profileImageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray383838
        view.layer.cornerRadius = 100
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private var profilImageBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 215 / 2
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()
    
    private var profileNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.backgroundColor = .black1E2125
        label.textAlignment = .center
        return label
    }()
    
    private var secondTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        label.text = "Loved Musics"
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: "CollectionTableViewCell")
        tableView.backgroundColor = .clear
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupView()
        fulfillData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func fulfillData() {
        FireBaseManager.shared.readFromFirestore(collection: "User", completion: { result in
            switch result {
            case .failure(let error):
                self.showAlert(text: error.localizedDescription)
            case .success(let documents):
                
                guard let userUid = FireBaseManager.shared.auth.currentUser?.uid else { return }
                
                for document in documents {
                    if userUid == document.documentID {
                        guard let firstName = document.data()["first_name"] as? String,
                              let lastName = document.data()["last_name"] as? String else { return }
                        self.profileNameLabel.text = "\(firstName.capitalized) \(lastName.capitalized)"
                    }
                }
            }
        })
    }
    
    private func setupView() {
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(headerContainerView)
        headerContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset((view.bounds.height / 100) * 13)
            make.leading.trailing.equalTo(view)
            make.height.equalTo((view.bounds.height / 100) * 20)
        }
        
        headerContainerView.addSubview(profilImageBorderView)
        profilImageBorderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(headerContainerView.snp.top)
            make.size.equalTo(215)
        }
        
        profilImageBorderView.addSubview(profileImageContainerView)
        profileImageContainerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(200)
        }
        
        headerContainerView.addSubview(profileNameLabel)
        profileNameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(profileImageContainerView.snp.bottom)
            make.height.equalTo(40)
        }
        
        headerContainerView.addSubview(secondTitleLabel)
        secondTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        scrollView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headerContainerView.snp.bottom)
            make.leading.trailing.equalTo(view)
            make.bottom.equalToSuperview()
            make.height.equalTo(150)
        }
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionTableViewCell") as? CollectionTableViewCell else {
            return UITableViewCell() }
        
        return cell
    }
    
}

extension ProfileViewController: UIImagePickerControllerDelegate {
    
}
 
