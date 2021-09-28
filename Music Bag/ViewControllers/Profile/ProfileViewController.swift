//
//  ProfileViewController.swift
//  Music Bag
//
//  Created by Premier on 28/09/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
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
        label.text = "Gabriel Olbrisch"
        label.backgroundColor = .black1E2125
        label.textAlignment = .center
        return label
    }()
    
    private var secondTitleView: UIView = {
        let view = UIView()
        view.backgroundColor = .black1E2125
        return view
    }()
    
    private var secondTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .white
        label.text = "Loved Musics"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor
        setupView()
    }
    
    private func setupView() {
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(headerContainerView)
        headerContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(view)
            make.height.equalTo((view.bounds.height / 100) * 15)
        }
        
        headerContainerView.addSubview(profilImageBorderView)
        profilImageBorderView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(headerContainerView.snp.bottom)
            make.size.equalTo(215)
        }
        
        profilImageBorderView.addSubview(profileImageContainerView)
        profileImageContainerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(headerContainerView.snp.bottom)
            make.size.equalTo(200)
        }
        
        headerContainerView.addSubview(profileNameLabel)
        profileNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.centerX.equalToSuperview()
            make.height.equalTo(40)
        }
        
        scrollView.addSubview(secondTitleView)
        secondTitleView.snp.makeConstraints { make in
            make.top.equalTo(profileImageContainerView.snp.bottom).offset(5)
            make.leading.trailing.equalTo(view)
        }
        
        secondTitleView.addSubview(secondTitleLabel)
        secondTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-15)
        }
    }
}
