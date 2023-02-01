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
// DONE
// - при добавлении/удалении фотографии в избранное, отображать актуальный список избранного
// DONE

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
    }	
}

// MARK: - Delegate
extension FavoritesViewController: PhotoGalleryManagerDelegate {
	func updateFavouritesList(array: [PresentPhotoModel]) {
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
        photoManager.delegate = self
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
        return photoManager.favouritesArray.count
    }
	
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellForFavoritesViewController.identifier, for: indexPath) as! CellForFavoritesViewController
        let favoriteImage = photoManager.favouritesArray[indexPath.row]
        cell.configure(favoriteImage)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailImageViewController()
        var pictureInfoModel = photoManager.favouritesArray[indexPath.row]
        let selectedIsFavourite = photoManager.favouritesArray.contains {
            return $0 == pictureInfoModel
        }
        pictureInfoModel.isFavourite = selectedIsFavourite
        detailVC.model = pictureInfoModel
        present(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Remove") { _, _, _ in

			// Удаление модели из массив
			let selectedModel = self.photoManager.favouritesArray[indexPath.row]
			self.photoManager.deleteFromFavourites(selectedModel)

			// Удаления ячейки из таблицы
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }

        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
}
