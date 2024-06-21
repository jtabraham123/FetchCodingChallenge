//
//  InMemoryImageRepository.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 6/11/24.
//

import Foundation
import Combine


import UIKit


protocol ImageRepository {
    func findImage(forKey key: String, imageUrl: URL?, retry: Bool)
}


// In memory image repository stores image from imageLoadService, was created so that two viewmodels (dessertListItemViewModel and DessertDetailViewModel) could share same image data

class InMemoryImageRepository: ImageRepository {
    var imageResultCache: [String: Result<UIImage, Error>] = [:]
    private let imageLoadService: ImageLoadServiceProtocol
    var imagePublishers = ImagePublishers()
    
    init(imageLoadService: ImageLoadServiceProtocol) {
        self.imageLoadService = imageLoadService
    }
    
    
    
    func findImage(forKey key: String, imageUrl: URL?, retry: Bool) {
        
        // first if its a retry then we reset image cache to nil
        if (retry) {
            // set to nil first then make network call
            imageResultCache[key] = nil
            imagePublishers.sendValueUpdate(forKey: key, imageResult: nil)
        }
        // if the imageResult exists in the cache send that
        if let imageResult = imageResultCache[key] {
            imagePublishers.sendValueUpdate(forKey: key, imageResult: imageResult)
        }
        else {
            // else use the service to make the network call
            imageLoadService.loadImage(url: imageUrl) { [weak self] result in
                DispatchQueue.main.async {
                    self?.imageResultCache[key] = result
                    self?.imagePublishers.sendValueUpdate(forKey: key, imageResult: result)
                }
            }
        }
    }
    
    func publishCurrentValueInCache(forKey key: String, publisher: PassthroughSubject<Result<UIImage, Error>?, Never>) {
        publisher.send(imageResultCache[key])
    }
    
    func publisher(forKey key: String) -> PassthroughSubject<Result<UIImage, Error>?, Never> {
        let publisher = imagePublishers.newPublisher(forKey: key)
        // Return the publisher, erasing its type
        return publisher
    }
}

