//
//  InMemoryImageRepository.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 6/11/24.
//

import Foundation


import UIKit


// TODO: Change to result type
protocol ImageRepository {
    func findImage(forKey key: String, imageUrl: URL?, completion: @escaping (Result<UIImage, Error>) -> Void)
}

class InMemoryImageRepository: ImageRepository {
    private var imageCache: [String: Result<UIImage, Error>] = [:]
    private let imageLoadService: ImageLoadServiceProtocol
    
    init(imageLoadService: ImageLoadServiceProtocol) {
        self.imageLoadService = imageLoadService
    }
    
    
    func findImage(forKey key: String, imageUrl: URL?, completion: @escaping (Result<UIImage, Error>) -> Void) {
        // Check if the image is already in the cache
        if let cachedImageResult = imageCache[key] {
            completion(cachedImageResult)
            return
        }
        // otherwise fetch from the network
        else {
            imageLoadService.loadImage(url: imageUrl) { [weak self] result in
                // add result to image cache, then call completion
                self?.imageCache[key] = result
                completion(result)
            }
        }
        
    }
}

