//
//  ImageLoadService.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 6/6/24.
//

import Foundation
import UIKit


protocol ImageLoadServiceProtocol {
    func loadImage(url: URL?, completion: @escaping (Result<UIImage, Error>) -> Void)
}

class ImageLoadService: ImageLoadServiceProtocol {
    
    func loadImage(url: URL?, completion: @escaping (Result<UIImage, Error>) -> Void) {
        
        guard let url = url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data, let uiImage = UIImage(data: data) else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            completion(.success(uiImage))
        }
        task.resume()
    }
}
