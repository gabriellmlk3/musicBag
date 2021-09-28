//
//  BaseViewAController.swift
//  Music Bag
//
//  Created by Premier on 05/09/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    var isLoading: Bool = false
    var loadView: UIView?
    
    public func setNormalNavigationController(title: String?) {
        navigationController?.navigationItem.title = title
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .black1E2125
        navigationController?.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .bold),
        ]
    }
    
    public func showAlert(with text: String) {
        UIView.animate(withDuration: 5) {
            let blurEffect = UIBlurEffect(style: .dark)
            let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
            
            self.view.addSubview(blurVisualEffectView)
            blurVisualEffectView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            let alertController = UIAlertController.init(title: "Atenção", message: text, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                blurVisualEffectView.removeFromSuperview()
            }))
            
            self.view.addSubview(blurVisualEffectView)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    public func showLoad(subview: UIView) {
        self.isLoading = true
        
        let blurEffect = UIBlurEffect(style: .dark)
        
        let blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurVisualEffectView.frame = CGRect(x: 90, y: 400, width: 250, height: 35)
        blurVisualEffectView.layer.cornerRadius = 16
        blurVisualEffectView.clipsToBounds = true
        self.loadView = blurVisualEffectView
        
        let loadingIndicator = UIView(frame: CGRect(x: 5, y: 2.5, width: 30, height: 30))
        loadingIndicator.backgroundColor = .white
        loadingIndicator.layer.cornerRadius = 15
        
        let viewController = UIViewController()
        viewController.view.backgroundColor = .white.withAlphaComponent(0.1)
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            UIView.animate(withDuration: 1.5, delay: 0, options: [.autoreverse, .repeat]) {
                loadingIndicator.frame = CGRect(x: 215, y: 2.5, width: 30, height: 30)
            } completion: { (_) in
                loadingIndicator.frame = CGRect(x: 90, y: 400, width: 250, height: 35)
            }
        }
        
        blurVisualEffectView.contentView.addSubview(loadingIndicator)
        self.view.insertSubview(blurVisualEffectView, aboveSubview: subview)
    }
    
    public func dismissLoad() {
        guard let view = self.loadView else { return }
        view.removeFromSuperview()
    }
}
