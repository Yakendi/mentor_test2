//
//  PhotoGalleryManager.swift
//  UnsplashAppCopy
//
//  Created by Soslan-Bek on 21.01.2023.
//

import Foundation

protocol PhotoGalleryManagerDelegate: AnyObject {
	func favouritesLists(array: [PresentPhotoModel])
}

final class PhotoGalleryManager {
	
	// MARK: - Singletone
	static let shared = PhotoGalleryManager()
	
	weak var delegate: PhotoGalleryManagerDelegate?
	
	// MARK: - Observables
	var presentPhotoArray: [PresentPhotoModel] = []
	var loadedImagesClosure: (([ImageURLs]) -> Void)? // unused
	
	var favouritesArray: [PresentPhotoModel] = [] {
		didSet {
			self.delegate?.favouritesLists(array: favouritesArray)
		}
	}

	// MARK: - Private
	private let network = NetworkManager()
	
	// MARK: - Constructor
	private init() {				
	}
	
	//MARK: - Fetch image
	func fetchImages(completion: @escaping (([ImageURLs]) -> Void)) {
		network.exploreImage { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let response):
				
				self.presentPhotoArray = response.map { item -> PresentPhotoModel in
                    return PresentPhotoModel(image: item.urls.full ?? "",
                                             userAvatar: item.user.profileImage.large,
											 userName: item.user.username,
											 instagram: item.user.instagramUsername ?? "")
				}

				// self.loadedImagesClosure?(response.map { $0.urls })
				completion(response.map { $0.urls })
			case .failure(let failure):
				print(failure.localizedDescription)
			}
		}
	}
}
