//
//  ExploreViewController.swift
//  UnsplashAppCopy
//
//  Created by Аслан Микалаев on 19.01.2023.
//

import UIKit
import SnapKit

class ExploreViewController: UIViewController {
    
    //MARK: - Public properties
	var collectionViewData: [ImageURLs] = []
	let photoGalleryManager = PhotoGalleryManager.shared
    
    //MARK: - UI
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: (view.frame.size.width - 40) / 3, height: (view.frame.size.width - 40) / 3)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CellForExploreImage.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Search"
        return searchBar
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        return indicator
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refresh
    }()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
		
		// Subscription to images array
		photoGalleryManager.loadedImagesClosure = { [weak self] imagesArray in
			self?.collectionViewData = imagesArray

			DispatchQueue.main.async {
				self?.collectionView.reloadData()
                self?.activityIndicator.stopAnimating()
			}
		}
    }
    
    //MARK: - Collection view refresh
    @objc private func refreshData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
}


//MARK: - Setup views
private extension ExploreViewController {
    func setup() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.addSubview(refreshControl)
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        navigationItem.titleView = searchBar
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}

//MARK: - Data source and Delegate
extension ExploreViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		// TODO: - Отображать данные (и лучше всего с activity indicator)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemOrange
        activityIndicator.stopAnimating()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		// TODO: - Передача presentationModel и отображение детальной информации
        let detailVC = DetailImageViewController()
        present(detailVC, animated: true)
    }
}
