//
//  DessertDetailViewModel.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/22/24.
//

import Foundation
import UIKit
import SwiftUI
import Combine

extension DessertDetailView {
    
    /* DessertDetailViewModel has both imageRepository and dessertDetailService to load in the dessert image and to load in the dessert recipe, it also contains the dessert model for presenting dessert data
     */
    class ViewModel: ViewModelType {
        var dessert: Dessert
        var imageRepository: InMemoryImageRepository
        @Published var dessertRecipeResult: Result<DessertRecipe, Error>? = nil
        @Published var imageResult: Result<UIImage, Error>? = nil
        @Published var ingredientsText: [String] = []
        @Published var instructionsText: [String] = []
        private let dessertDetailService: DessertDetailService
        private var cancellables = Set<AnyCancellable>()
        
        init(dessert: Dessert, dessertDetailService: DessertDetailService, imageRepository: InMemoryImageRepository) {
            self.dessert = dessert
            self.dessertDetailService = dessertDetailService
            self.imageRepository = imageRepository
            self.subscribeToImageResult()
            self.fetchRecipe(retry: false)
        }
        
        func subscribeToImageResult() {
            let publisher = imageRepository.publisher(forKey: dessert.id)
            publisher.sink { [weak self] result in
                DispatchQueue.main.async {
                    self?.imageResult = result
                }
            }
            .store(in: &cancellables)
            imageRepository.publishCurrentValueInCache(forKey: dessert.id, publisher: publisher)
        }
        
        func getImage(retry: Bool) {
            imageRepository.findImage(forKey: dessert.id, imageUrl: URL(string: dessert.thumbnail), retry: retry)
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
                    if case .success(let dessertRecipe) = result {
                        self?.ingredientsText = dessertRecipe.formattedIngredients()
                        self?.instructionsText = dessertRecipe.formattedInstructions()
                    }
                }
            }
        }
        
        
    }
}
