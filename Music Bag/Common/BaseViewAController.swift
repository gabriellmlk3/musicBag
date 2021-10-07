//
//  BaseViewAController.swift
//  Music Bag
//
//  Created by Premier on 05/09/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    var isLoading: Bool = false
    
    private lazy var loadContainerView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        view.backgroundColor = .gray.withAlphaComponent(0.3)
        return view
    }()
    
    private lazy var loadView = SpinnerView(frame: CGRect(x: self.loadContainerView.bounds.width / 2 - 50, y: self.loadContainerView.bounds.height / 2 - 50, width: 100, height: 100))
    
    public func setNormalNavigationController(title: String?) {
        navigationController?.navigationItem.title = title
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .black1E2125
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .bold),
        ]
    }
    
    public func showAlert(text: String) {
        let alertController = UIAlertController.init(title: "Warning", message: text, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            alertController.dismiss(animated: true, completion: nil)
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func showLoad() {
        loadContainerView.addSubview(loadView)
        view.addSubview(loadContainerView)
        self.tabBarController?.tabBar.layer.zPosition = -1
    }
    
    public func dismissLoad() {
        loadContainerView.removeFromSuperview()
        self.tabBarController?.tabBar.layer.zPosition = 0
    }
}
