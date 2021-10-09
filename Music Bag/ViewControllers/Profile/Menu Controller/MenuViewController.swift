//
//  MenuViewController.swift
//  Music Bag
//
//  Created by Premier on 08/10/21.
//

import UIKit

class MenuViewController: UIViewController {
    
    private var logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black1E2125
        button.setTitleColor(.white, for: .normal)
        button.setAttributedTitle(NSAttributedString(string: "Logout", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .semibold)]), for: .normal)
        button.addTarget(self, action: #selector(logout), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black1E2125
        setupLayout()
    }
    
    private func setupLayout() {
        
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalToSuperview().offset(15)
        }
    }
    
    @objc
    private func logout() {
        if FireBaseManager.shared.signOut() {
            self.navigationController?.pushViewController(LoginViewController(), animated: true)
        }
    }

}
