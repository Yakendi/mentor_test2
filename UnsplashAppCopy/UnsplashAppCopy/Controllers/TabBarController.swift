//
//  ViewController.swift
//  UnsplashAppCopy
//
//  Created by Аслан Микалаев on 19.01.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    //MARK: - Public properties
    let exploreVC = PicturesListViewController()
    let favoritesVC = FavoritesViewController()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupTabs()
		_ = favoritesVC.view
    }
    
    //MARK: - Tabs
    private func setupTabs() {
        let navigationControllerForExploreVC = UINavigationController(rootViewController: exploreVC)
        let navigationControllerForFavoritesVC = UINavigationController(rootViewController: favoritesVC)
        
        navigationControllerForExploreVC.tabBarItem = UITabBarItem(title: "Explore",
                                                                   image: UIImage(named: "explore"),
                                                                   tag: 1)
        navigationControllerForFavoritesVC.tabBarItem = UITabBarItem(title: "Favorites",
                                                                     image: UIImage(named: "favourite"),
                                                                     tag: 2)
        
        setViewControllers([navigationControllerForExploreVC, navigationControllerForFavoritesVC], animated: true)
        
        tabBar.layer.borderColor = UIColor.systemGray.cgColor
        tabBar.layer.borderWidth = 0.2
        tabBar.tintColor = .systemPink
    }
}

