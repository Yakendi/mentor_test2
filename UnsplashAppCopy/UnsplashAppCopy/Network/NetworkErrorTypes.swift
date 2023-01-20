//
//  NetworkErrorTypes.swift
//  UnsplashAppCopy
//
//  Created by Аслан Микалаев on 19.01.2023.
//

import Foundation

enum NetworkErrorTypes: Error {
    case invalidURL
    case emptyData
    case error(error: Error)
}
