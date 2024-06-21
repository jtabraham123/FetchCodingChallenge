//
//  ImagePublishers.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 6/19/24.
//

import Foundation
import Combine
import UIKit


class ImagePublishers {
    var publishers: [[String: PassthroughSubject<Result<UIImage, Error>?, Never>]] = [[:]]
    
    func newPublisher(forKey key: String) -> PassthroughSubject<Result<UIImage, Error>?, Never> {
        
        // Create a new publisher
        let publisher = PassthroughSubject<Result<UIImage, Error>?, Never>()
        checkPublishersArray(forKey: key, publisher: publisher)
       
        return publisher
    }
    
        // sends update for all publishers
    func sendValueUpdate(forKey key:String, imageResult: Result<UIImage, Error>?) {
        for dict in publishers {
            dict[key]?.send(imageResult)
        }
    }
    
    // checks publishers array, adds new dictionary if needed
    func checkPublishersArray(forKey key: String, publisher: PassthroughSubject<Result<UIImage, Error>?, Never>) {
        
        var publisherArrayEntryExists = false
        
        for dict in publishers {
            // if there is a publisher at this key
            if let existingPublisher = dict[key] {
                continue
            }
            // publisher array entry exists
            else {
                publisherArrayEntryExists = true
            }
        }
        // if theres no array entry, add a new one
        if (!publisherArrayEntryExists) {
            publishers.append([:])
        }
        let lastIndex = publishers.count - 1
        publishers[lastIndex][key] = publisher
    }
}
