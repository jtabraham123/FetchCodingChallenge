//
//  DessertListViewModel.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/21/24.
//

import Foundation



// DessertListViewModel makes the api request for dessert items upon initialization

protocol DessertListViewModelDelegate: AnyObject {
    func didRecieveDesserts(_ desserts: [Dessert])
}

extension DessertListView {
    class ViewModel: ViewModelType {
        
        @Published var dessertResult: Result<[Dessert], Error>? = nil
        private let dessertListService: DessertListServiceProtocol
        
        private weak var delegate: DessertListViewModelDelegate?
        
        init(dessertListService: DessertListServiceProtocol) {
            self.dessertListService = dessertListService
        }
        
        func addDelegate(delegate: DessertListViewModelDelegate) {
            self.delegate = delegate
        }
        
        func getDesserts(retry: Bool) {
            // make sure to set result to nil for progress view to come back on hitting retry
            if (retry) {
                DispatchQueue.main.async {
                    self.dessertResult = nil
                }
            }
            dessertListService.fetchDesserts { [weak self] result in
                if case .success(let desserts) = result {
                    // if successful, create the viewmodels in the coordinator
                    self?.delegate?.didRecieveDesserts(desserts)
                }
                DispatchQueue.main.async {
                    self?.dessertResult = result
                }
            }
        }
    }
}
