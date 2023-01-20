//
//  FavoritesViewController.swift
//  UnsplashAppCopy
//
//  Created by Аслан Микалаев on 19.01.2023.
//

import UIKit

class FavoritesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationItem.title = "favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
