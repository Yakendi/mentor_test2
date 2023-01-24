//
//  NetworkManager.swift
//  UnsplashAppCopy
//
//  Created by Аслан Микалаев on 19.01.2023.
//

import Foundation

class NetworkManager {
    
    //MARK: - Base URL
    let baseURL = "https://api.unsplash.com/photos/?client_id=SR06pjmvFFAczVYEUE0htljhCG34JbLATNtVP5jrXpA&order_by=ORDER&per_page=30"
    
    //MARK: - Main request
    private func makeRequest<T: Codable>(_ url: URL, completion: @escaping (Result<T, NetworkErrorTypes>) -> Void) {
	
        URLSession.shared.dataTask(with: url) { data, responce, error in
            if let error = error {
                completion(.failure(.error(error: error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.emptyData))
                return
            }
            
            do {
                let unsplashData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(unsplashData))
            } catch let error {
                completion(.failure(.error(error: error)))
            }
        }.resume()
    }
    
    //MARK: - Explore image
    func exploreImage(completion: @escaping (Result<[UnsplashModel], NetworkErrorTypes>) -> Void) {
        let url = baseURL
        let converedURL = url.convertToURL()
        
        makeRequest(converedURL, completion: completion)
    }
}

//MARK: - Converte to url

extension String {
    func convertToURL() -> URL {
        return URL(string: self)!
    }
}
