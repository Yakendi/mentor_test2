//
//  PresentPhotoModel.swift
//  UnsplashAppCopy
//
//  Created by Аслан Микалаев on 23.01.2023.
//

import UIKit

struct PresentPhotoModel: Equatable {
	let id: String
    let image: String
    let thumbImage: String
    let userAvatar: String
    let userName: String
    let instagram: String
	var isFavourite: Bool = false
	
	static func == (lhs: PresentPhotoModel, rhs: PresentPhotoModel) -> Bool {
		return lhs.id == rhs.id
	}
}
