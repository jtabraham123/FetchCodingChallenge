//
//  DessertImageViewModel.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/21/24.
//

import Foundation
import UIKit

// Loads image from the url and sets title of dessert

extension DessertListItemView {
    
    class ViewModel: ObservableObject {
        var url: URL?
        var dessertTitle: String
        @Published var loadResult: Result<UIImage, Error>? = nil
        private let imageLoadService: ImageLoadServiceProtocol
        
        init(stringUrl: String, dessertTitle: String, imageLoadService: ImageLoadServiceProtocol) {
            self.url = URL(string: stringUrl)
            self.dessertTitle = dessertTitle
            self.imageLoadService = imageLoadService
            self.getImage()
        }
        
        func getImage() {
            imageLoadService.loadImage(url: self.url) { [weak self] result in
                DispatchQueue.main.async {
                    self?.loadResult = result
                }
            }
        }
    }
}
