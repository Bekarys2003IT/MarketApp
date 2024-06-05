//
//  TabBarController.swift
//  MarketApp
//
//  Created by Бекарыс Сандыгали on 15.05.2024.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.setBars()
        self.tabBar.barTintColor = .darkGray
        self.tabBar.tintColor = UIColor(red: 35/255, green: 129/255, blue: 56/255, alpha: 1.0)
        self.tabBar.unselectedItemTintColor = .darkGray
        navigationItem.hidesBackButton = true
    }
    private func setBars(){
        let homeVC = self.createNav(with: "Home", and: UIImage(systemName: "house"), vc: HomeViewController())
        let browseVC = self.createNav(with: "Browse", and: UIImage(systemName: "fork.knife"), vc: BrowseViewController())
        let basketVC = self.createNav(with: "Basket", and: UIImage(systemName: "basket"), vc: BasketViewController())
        let profileVC = self.createNav(with: "Profile", and: UIImage(systemName: "person"), vc: ProfileViewController())
        self.setViewControllers([homeVC,browseVC,basketVC,profileVC], animated: true)
        selectedIndex = 1
    }
    private func createNav(with title:String, and image:UIImage?, vc:UIViewController) -> UINavigationController{
        let nav  = UINavigationController(rootViewController: vc)
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        return nav
    }
    
}
