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
        
        
        init(stringUrl: String?, dessertTitle: String?) {
            self.url = URL(string: stringUrl)
            self.dessertTitle = dessertTitle
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
