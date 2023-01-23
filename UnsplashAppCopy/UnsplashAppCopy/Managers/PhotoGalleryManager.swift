//
//  PhotoGalleryManager.swift
//  UnsplashAppCopy
//
//  Created by Soslan-Bek on 21.01.2023.
//

import Foundation

final class PhotoGalleryManager {
	
//    //MARK: - Singletone
//    static let shared = PhotoGalleryManager()
//    
//    // MARK: - Observable
//    var favouritesImages: [ImageURLs] = []
//    var presentPhotoArray: [PresentPhotoModel] = []
//    
//    var loadedImagesClosure: (([ImageURLs]) -> Void)?
//    
//    // MARK: - Private
//    private let network = NetworkManager()
//    
//    // MARK: - Constructor
//	private init() {
//		
//        fetchImage()
//	}
//    
//    //MARK: - Fetch image
//    func fetchImage() {
//        network.exploreImage { [weak self] result in
//            guard let self = self else { return }
//            switch result {
//            case .success(let response):
//                
//                self.presentPhotoArray = response.map { item -> PresentPhotoModel in
//                    return PresentPhotoModel(image: item.urls.full,
//                                             userAvatar: item.user.profileImage.medium,
//                                             userName: item.user.username,
//                                             instagram: item.user.instagramUsername ?? "",
//                                             description: item.description ?? "",
//                                             location: item.user.location)
//                }
//                
//                self.loadedImagesClosure?(response.map { $0.urls })
//            case .failure(let failure):
//                print(failure.localizedDescription)
//            }
//        }
//    }
}
