//
//  MenuContainerViewController.swift
//  Music Bag
//
//  Created by Premier on 08/10/21.
//

import UIKit

class ContainerViewController: UIViewController {
    
    private var menuController: UIViewController?
    private var centerController: UIViewController?
    var isExpanded: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureHomeViewController()

    }
   
    private func configureHomeViewController() {
        let rootViewController = ProfileViewController()
        rootViewController.delegate = self
        centerController = UINavigationController(rootViewController: rootViewController)

        guard let controller = centerController else { return }
        view.addSubview(controller.view)
        addChild(controller)
        controller.didMove(toParent: self)
    }
    
    private func configureMenuContainerViewController() {
        if menuController == nil {
            menuController = MenuViewController()
            view.insertSubview(menuController?.view ?? UIView(), at: 0)
            addChild(menuController ?? UIViewController())
            menuController?.didMove(toParent: self)
            print("Did add menu controller")
        }
    }
    
    private func showMenuController(shouldExpande: Bool) {
        DispatchQueue.main.async {
            if shouldExpande {
                UIView.animate(withDuration: 0.3) {
                    self.centerController?.view.frame.origin.x = (self.centerController?.view.frame.width ?? 0) - 170
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.centerController?.view.frame.origin.x = 0
                }
            }
        }
    }
    
}

extension ContainerViewController: ProfileViewControllerDelegate {
    
    func toggleMenu() {
        
        if !isExpanded {
            self.configureMenuContainerViewController()
        }
        
        isExpanded.toggle()
        self.showMenuController(shouldExpande: self.isExpanded)
    }
    
    
}
