//
//  ImageModel.swift
//  UnsplashAppCopy
//
//  Created by Аслан Микалаев on 20.01.2023.
//

import Foundation

struct UnsplashModel: Codable {
    let id: String
    let created_at: String
    let description: String
    let urls: ImageURLs
    let user: UserModel
    let location: LocationModel
    let downloads: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case created_at = "createdAt"
        case description
        case urls
        case user
        case location
        case downloads
    }
}
