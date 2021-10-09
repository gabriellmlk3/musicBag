//
//  MenuViewController.swift
//  Music Bag
//
//  Created by Premier on 08/10/21.
//

import UIKit

class MenuViewController: UIViewController {
    
    private let logoutButton = ProfileMenuButton(title: "Logout", icon: .logoutIcon, target: self, action: #selector(logout))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black1E2125
        setupLayout()
    }
    
    
    
    private func setupLayout() {
        
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
    }
    
    @objc
    private func logout() {
        if FireBaseManager.shared.signOut() {
            let alert = UIAlertController(title: "Should leave?", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
                self.navigationController?.pushViewController(LoginViewController(), animated: true)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
                alert.dismiss(animated: true, completion: nil)
            }))
            
            navigationController?.present(alert, animated: true, completion: nil)
        }
        
    }

}
