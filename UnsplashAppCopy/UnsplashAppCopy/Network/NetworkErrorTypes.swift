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

extension NetworkErrorTypes: LocalizedError {
	var errorDescription: String? {
		switch self {
		case .invalidURL:
			return NSLocalizedString("Невалидынй url.", comment: "My error")
		case .emptyData:
			return NSLocalizedString("Нет данных.", comment: "My error")
		case .error(let error):
			return NSLocalizedString("\(error.localizedDescription)", comment: "My error")
		}
	}
}
