//
//  PhotoGalleryManager.swift
//  UnsplashAppCopy
//
//  Created by Soslan-Bek on 21.01.2023.
//

import Foundation

struct PresentPhotoModel {
	let image: String
	let userAvatat: String
	let firstName: String
	let userName: String
	let description: String
	let location: String
}

final class PhotoGalleryManager {
	
	// MARK: - Observable
	var favouritesImages: [ImageURLs] = []
	var presentPhotoArray: [PresentPhotoModel] = []
	
	var loadedImagesClosure: (([ImageURLs]) -> Void)?
	
	// MARK: - Private
	private let network = NetworkManager()
	
	// MARK:  -
	static let shared = PhotoGalleryManager()
	private init() {
		
//		network.exploreImage { [weak self] result in
//			switch result {
//			case .success(let response):
//				
////				self?.presentPhotoArray = response.map { item -> PresentPhotoModel in
////					return PresentPhotoModel(image: item.urls.full,
////											 userAvatat: item.user.profileImage.medium,
////											 firstName: item.user.name,
////											 userName: item.user.username,
////											 description: item.description ?? "",
////											 location: item.user.location)
////				}
//				
//				self?.loadedImagesClosure?(response.map { $0.urls })
//			case .failure(let failure):
//				print(failure.localizedDescription)
//			}
//		}
	}
}
