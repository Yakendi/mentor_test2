//
//  PhotoGalleryManager.swift
//  UnsplashAppCopy
//
//  Created by Soslan-Bek on 21.01.2023.
//

import Foundation

protocol PhotoGalleryManagerDelegate: AnyObject {	
	// Используем, чтобы обновлять таблицу на экране списка избранных
	func updateFavouritesList()
}

final class PhotoGalleryManager {
    
    // MARK: - Singletone
    static let shared = PhotoGalleryManager()
    
    // MARK: - Public properties
    var presentPhotoArray: [PresentPhotoModel] = []
    var favouritesArray: [PresentPhotoModel] = []
    weak var delegate: PhotoGalleryManagerDelegate?

    // MARK: - Private properties
    private let dataManager = DataBaseManager()
	private let network = NetworkManager()
	
	// MARK: - Constructor
	private init() {
		
		favouritesArray = dataManager.fetchFavouritesArray()
	}
	
	// MARK: - Update favorites list
	func addToFavourites(_ model: PresentPhotoModel) {
		//
		self.favouritesArray.append(model)
		print("\(model.userName) image is added to favourites")
		
		self.dataManager.saveFavouriteModel(model)		
		self.delegate?.updateFavouritesList()
	}
	
	///
	/// isNeedReload - указываем true если нам нужно вызывать tableView.reloadData
	func deleteFromFavourites(_ model: PresentPhotoModel, isNeedReload: Bool) {
		// 1
//		var array = self.favouritesArray
//		array.removeAll { $0 == model }
//		self.favouritesArray = array				
		
		// 2
		let filteredArray = self.favouritesArray.filter { $0 != model }
		self.favouritesArray = filteredArray
        self.dataManager.removeFromFavoritesModel(model)
		
		if isNeedReload {
			self.delegate?.updateFavouritesList()
		}
		
		print("\(model.userName) image is deleted from list")
	}
	
	func fetchImages(completion: @escaping (([ImageURLs]) -> Void)) {
		network.exploreImage { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let response):
				
				// TODO: - Подумать как скачивать и сохранять картинки в структуре 
				self.presentPhotoArray = response.map { item -> PresentPhotoModel in
					return PresentPhotoModel(id: item.id,
											image: item.urls.regular ?? "",
                                             thumbImage: item.urls.thumb ?? "",
                                             userAvatar: item.user.profileImage.medium,
											 userName: item.user.username,
											 instagram: item.user.instagramUsername ?? "")
				}

				completion(response.map { $0.urls })
			case .failure(let failure):
				print(failure.localizedDescription)
			}
		}
	}
}
