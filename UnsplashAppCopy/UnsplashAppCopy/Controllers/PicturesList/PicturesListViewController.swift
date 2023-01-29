//
//  PicturesViewController.swift
//  UnsplashAppCopy
//
//  Created by Аслан Микалаев on 19.01.2023.
//

import UIKit
import SnapKit

class PicturesListViewController: UIViewController {
	
	//MARK: - Public properties
	var collectionViewData: [ImageURLs] = []
	let photoGalleryManager = PhotoGalleryManager.shared
	//    let network = NetworkManager()
	
	//MARK: - UI
	private lazy var collectionView: UICollectionView = {
		let layout = UICollectionViewFlowLayout()
		layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
		layout.itemSize = CGSize(width: (view.frame.size.width - 40) / 3,
								 height: (view.frame.size.width - 40) / 3)
		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.register(PictureCollectionViewCell.self,
								forCellWithReuseIdentifier: PictureCollectionViewCell.identifier)
		return collectionView
	}()
	
	private lazy var searchBar: UISearchBar = {
		let searchBar = UISearchBar()
		searchBar.searchBarStyle = .minimal
		searchBar.backgroundColor = .systemBackground
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
	
	// MARK: - Life cycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setup()
		
		
		// It's if we subscribe to closure
		// manager
		//	- closure A
		
		// vc
		// 	- susbcribe to closure A
		// 	- get data
		// ✅  WILL WORK
		
		// vc
		// 	- closure A already getted data
		// 	- subscribe to closure A
		// 🛑  WILL NOT WORK
		
		
		// It's if we take data via completion block
		fetchImagesWithCompletionBlock()
	}
	
	// Subscription to images array
	func fethcImagesWithSusbcribe() {
		photoGalleryManager.loadedImagesClosure = { [weak self] imagesArray in
			self?.collectionViewData = imagesArray
			
			DispatchQueue.main.async {
				self?.collectionView.reloadData()
				self?.activityIndicator.stopAnimating()
			}
		}
	}
	
	func fetchImagesWithCompletionBlock() {
		photoGalleryManager.fetchImages { [weak self] imagesArray in
			self?.collectionViewData = imagesArray
			
			DispatchQueue.main.async {
				self?.collectionView.reloadData()
				self?.activityIndicator.stopAnimating()
			}
		}
	}
	
	//MARK: - Collection view refresh
	@objc private func refreshData() {
        self.fetchImagesWithCompletionBlock()
        self.collectionView.reloadData()
        self.refreshControl.endRefreshing()
    }
}

//MARK: - Setup views
private extension PicturesListViewController {
	func setup() {
		setupViews()
		setupConstraints()
	}
	
	func setupViews() {
		view.backgroundColor = .systemBackground
		navigationItem.titleView = searchBar
		view.addSubview(collectionView)
		view.addSubview(activityIndicator)
		activityIndicator.startAnimating()
		collectionView.addSubview(refreshControl)
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
extension PicturesListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		collectionViewData.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		// TODO: - Отображать данные (и лучше всего с activity indicator)
		// DONE 
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PictureCollectionViewCell.identifier, for: indexPath) as! PictureCollectionViewCell
        cell.backgroundColor = .systemGray6
		let pictureModel = collectionViewData[indexPath.item]
		cell.configure(pictureModel)
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let detailVC = DetailImageViewController()
		var pictureInfoModel = photoGalleryManager.presentPhotoArray[indexPath.item]
		
		// TODO: - Update 
		let selectedIsFavourite = photoGalleryManager.favouritesArray.contains {
			return $0 == pictureInfoModel
		}
		pictureInfoModel.isFavourite = selectedIsFavourite
		
		
		detailVC.model = pictureInfoModel		
		present(detailVC, animated: true)
	}
}
