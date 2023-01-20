//
//  ExploreViewController.swift
//  UnsplashAppCopy
//
//  Created by Аслан Микалаев on 19.01.2023.
//

import UIKit

class ExploreViewController: UIViewController {
    
    //MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView()
        return collectionView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.barTintColor = .white
        return searchBar
    }()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.titleView = searchBar
    }
}


//MARK: - Setup views
private extension ExploreViewController {
    func setup() {
        
    }
    
    func setupViews() {
        
    }
    
    func setupConstraints() {
        
    }
}

//MARK: - Data source and Delegate
extension ExploreViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
}
