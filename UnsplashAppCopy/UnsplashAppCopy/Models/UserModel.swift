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
    let instagram_username: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case username
        case name
        case instagram_username = "instagram"
    }
}
