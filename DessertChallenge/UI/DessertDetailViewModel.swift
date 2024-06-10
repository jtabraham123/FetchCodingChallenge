//
//  DessertDetailViewModel.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/22/24.
//

import Foundation

extension DessertDetailView {
    
    /* DessertDetailViewModel makes the network request and decodes the json with its custom
     decoding function. I thought it was easier to just write the decoding function here than
     using combine framework like earlier
     */
    class ViewModel: ObservableObject {
        var id: String = ""
        @Published var dessertRecipeResult: Result<DessertRecipe, Error>? = nil
        private let dessertDetailService: DessertDetailService
        
        init(id: String, dessertDetailService: DessertDetailService) {
            self.id = id
            self.dessertDetailService = dessertDetailService
        }
        
        func fetchRecipe() {
            dessertDetailService.fetchDessertDetails(idString: id) { [weak self] result in
                DispatchQueue.main.async {
                    self?.dessertRecipeResult = result
                }
            }
        }
        
        
    }
}
