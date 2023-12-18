//
//  MainTabBarController.swift
//  Rick_and_Morty
//
//  Created by Евгений on 14.12.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        navigationItem.hidesBackButton = true
        generateTabBar()
        
    }
    
    func generateTabBar() {
        viewControllers = [
        generateViewController(viewController: EpisodesViewController(), image: UIImage(systemName: "house")),
        generateViewController(viewController: FavoritsViewController(), image: UIImage(systemName: "heart"))
        ]
        
    }
    
    func generateViewController(viewController: UIViewController, image: UIImage?) -> UIViewController {
        viewController.tabBarItem.image = image
        return viewController
    }
    
}

