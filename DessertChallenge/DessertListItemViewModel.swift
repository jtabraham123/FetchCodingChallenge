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
        let url: URL?
        let dessertTitle: String
        @Published var loadedImage: UIImage? = nil
        
        init(urlString: String, dessertTitle: String) {
            url = URL(string: urlString)
            self.dessertTitle = dessertTitle
            loadImage()
        }
        
        func loadImage() {
            if (url != nil) {
                let task = URLSession.shared.dataTask(with: url!) { data, response, error in
                    if let data = data, let uiImage = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.loadedImage = uiImage
                        }
                    }
                }
                task.resume()
            }
        }
    }
}
