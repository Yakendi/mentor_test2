//
//  UserModel.swift
//  UnsplashAppCopy
//
//  Created by Аслан Микалаев on 20.01.2023.
//

import Foundation

struct UserModel: Codable {
    let id: String
    let username: String
    let name: String
	let location: String
    let profileImage: ProfileImageModel
    let instagramUsername: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
		case location
        case profileImage = "profile_image"
        case instagramUsername = "instagram_username"
    }
}
