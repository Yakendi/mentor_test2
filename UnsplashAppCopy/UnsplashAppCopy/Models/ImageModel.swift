//
//  ImageModel.swift
//  UnsplashAppCopy
//
//  Created by Аслан Микалаев on 20.01.2023.
//

import Foundation

struct ImageModel: Codable {
    let id: String
    let created_at: String
    let description: String
    let user: UserModel
    let location: LocationModel
    let downloads: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case created_at = "createdAt"
        case description
        case user
        case location
        case downloads
    }
}
