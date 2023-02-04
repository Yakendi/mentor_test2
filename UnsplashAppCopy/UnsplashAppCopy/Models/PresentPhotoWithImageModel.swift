//
//  PresentPhotoWithImageModel.swift
//  UnsplashAppCopy
//
//  Created by Soslan-Bek on 04.02.2023.
//

import UIKit

struct PresentPhotoWithImageModel {
	let id: String
	let image: UIImage
	let thumbImage: UIImage
	let userAvatar: UIImage
	let userName: String
	let instagram: String
	var isFavourite: Bool = false
}
