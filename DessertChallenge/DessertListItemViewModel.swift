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
        @Published var loadResult: Result<UIImage, Error>? = nil
        
        
        init(urlString: String, dessertTitle: String) {
            url = URL(string: urlString)
            self.dessertTitle = dessertTitle
            loadImage()
        }
        
        func loadImage() {
            guard let url = url else {
                DispatchQueue.main.async {
                    self.loadResult = .failure(NetworkError.invalidURL)
                }
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.loadResult = .failure(error)
                    }
                    return
                }
                guard let data = data, let uiImage = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        self.loadResult = .failure(NetworkError.invalidData)
                    }
                    return
                }

                DispatchQueue.main.async {
                    self.loadResult = .success(uiImage)
                }
            }
            task.resume()
        }
    }
}
