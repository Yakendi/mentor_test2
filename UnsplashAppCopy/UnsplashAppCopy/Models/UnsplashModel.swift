//
//  ImageModel.swift
//  UnsplashAppCopy
//
//  Created by Аслан Микалаев on 20.01.2023.
//

import Foundation

struct UnsplashModel: Codable {
    let id: String
    let createdAt: String
    let description: String?
    let altDescription: String?
    let urls: ImageURLs
    let user: UserModel
    let location: LocationModel
    let downloads: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case createdAt = "created_at"
        case description
        case altDescription = "alt_description"
        case urls
        case user
        case location
        case downloads
    }
}
