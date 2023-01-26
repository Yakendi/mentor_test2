//
//  FavoritesViewController.swift
//  UnsplashAppCopy
//
//  Created by Аслан Микалаев on 19.01.2023.
//

import UIKit
import SnapKit

// TODO: -
// - Сделать список через таблицу
// - при добавлении/удалении фотографии в избранное, отображать актуальный список избранного 

class FavoritesViewController: UIViewController {
    
    // MARK: - Puclic properties
    private var favoriteImages = [PresentPhotoModel]()
	private let photoManager = PhotoGalleryManager.shared		
    
    //MARK: - UI
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CellForFavoritesViewController.self, forCellReuseIdentifier: CellForFavoritesViewController.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
		photoManager.delegate = self
    }
}

// MARK: - Delegate
extension FavoritesViewController: PhotoGalleryManagerDelegate {
	func favouritesLists(array: [PresentPhotoModel]) {
		self.favoriteImages = array
		self.tableView.reloadData()
	}
}

//MARK: - Setup views
private extension FavoritesViewController {
    func setup() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

//MARK: - Collection view data source and delegate
extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return favoriteImages.count
    }
	
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellForFavoritesViewController.identifier, for: indexPath) as! CellForFavoritesViewController
        return cell
    }
}
