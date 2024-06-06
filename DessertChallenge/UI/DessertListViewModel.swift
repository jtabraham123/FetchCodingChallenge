//
//  DessertListViewModel.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/21/24.
//

import Foundation

// DessertListViewModel makes the api request for dessert items upon initialization
extension DessertListView {
    class ViewModel: ObservableObject {
        
        @Published var dessertResult: Result<[Dessert], Error>? = nil
        private let dessertListService: DessertListServiceProtocol
        
        init(dessertListService: DessertListServiceProtocol) {
            self.dessertListService = dessertListService
        }
        
        func getDesserts() {
            dessertListService.fetchDesserts { [weak self] result in
                DispatchQueue.main.async {
                    self?.dessertResult = result
                }
            }
        }
    }
}
