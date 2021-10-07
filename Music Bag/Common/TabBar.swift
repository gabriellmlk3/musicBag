//
//  ViewController.swift
//  Music Bag
//
//  Created by Premier on 24/09/21.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black1E2125
        UITabBar.appearance().barTintColor = .black1E2125
        delegate = self
        tabBar.tintColor = .white
        setupViewControllers()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let tabBarHeight: CGFloat = 70
        var tabFrame = tabBar.frame
        tabFrame.size.height = tabBarHeight
        tabFrame.origin.y = view.frame.size.height - tabBarHeight
        tabBar.frame = tabFrame
        
        guard let items = self.tabBar.items else { return }
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -20, right: 0)
        }
    }
    
    func setupViewControllers() {
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .crossDissolve
        viewControllers = [
            createNavController(viewController: HomeViewController(), title: "Musics", icon: .homeIcon, index: 0),
            createNavController(viewController: NoPlayingMusicViewController(), title: "", icon: .tabBarPlayIcon, index: 1),
            createNavController(viewController: LoginViewController(), title: "Login", icon: .userIcon, index: 2)
        ]
        }
    
    private func createNavController(viewController: UIViewController, title: String, icon: UIImage, index: Int) -> UINavigationController {
        let iconResized = icon.resizeWithScaleAspectFitMode(to: 30, resizeFramework: .coreGraphics)
        viewController.tabBarItem = UITabBarItem(title: nil, image: iconResized, tag: index)
        viewController.navigationItem.title = title
        let navigationController = UINavigationController(rootViewController: viewController)
        let backBarButtonItem = UIButton(type: .system)
        backBarButtonItem.setImage(.backArrowIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        navigationController.navigationController?.navigationItem.backBarButtonItem = UIBarButtonItem(customView: backBarButtonItem)
        navigationController.navigationBar.tintColor = .white
        navigationController.delegate = self
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.barTintColor = .black1E2125
        navigationController.navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30, weight: .bold),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        return navigationController
    }

}

extension TabBar: UITabBarControllerDelegate, UINavigationControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        guard let fromView = selectedViewController?.view, let toView = viewController.view else { return false }
        
        if index == 1 {
            if let musicViewController = MusicManager.shared.lastPlayedViewController {
                viewController.hidesBottomBarWhenPushed = true
                let navController = selectedViewController as? UINavigationController
                navController?.pushViewController(musicViewController, animated: true)
                return false
            }
        }
        
        if fromView != toView {
            UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionCrossDissolve], completion: nil)
        }
        return true
    }
}
