//
//  DessertDetailViewModel.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/22/24.
//

import Foundation
import UIKit

extension DessertDetailView {
    
    /* DessertDetailViewModel makes the network request and decodes the json with its custom
     decoding function. I thought it was easier to just write the decoding function here than
     using combine framework like earlier
     */
    class ViewModel: ViewModelType {
        var dessert: Dessert
        var imageRepository: ImageRepository
        @Published var dessertRecipeResult: Result<DessertRecipe, Error>? = nil
        @Published var imageResult: Result<UIImage, Error>? = nil
        private let dessertDetailService: DessertDetailService
        
        init(dessert: Dessert, dessertDetailService: DessertDetailService, imageRepository: ImageRepository) {
            self.dessert = dessert
            self.dessertDetailService = dessertDetailService
            self.imageRepository = imageRepository
            self.getImage(retry: false)
            self.fetchRecipe(retry: false)
        }
        
        func getImage(retry: Bool) {
            if (retry) {
                DispatchQueue.main.async {
                    self.imageResult = nil
                }
            }
            imageRepository.findImage(forKey: dessert.id, imageUrl: URL(string: dessert.thumbnail)) { [weak self] result in
                DispatchQueue.main.async {
                    self?.imageResult = result
                }
            }
        }
        
        func fetchRecipe(retry: Bool) {
            if (retry) {
                DispatchQueue.main.async {
                    self.dessertRecipeResult = nil
                }
            }
            
            dessertDetailService.fetchDessertDetails(idString: dessert.id) { [weak self] result in
                DispatchQueue.main.async {
                    self?.dessertRecipeResult = result
                }
            }
        }
        
        
    }
}
