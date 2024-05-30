//
//  DessertListViewModel.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/21/24.
//

import Foundation
import Combine

// DessertListViewModel makes the api request for dessert items upon initialization
extension DessertListView {
    class ViewModel: ObservableObject {
        
        private var cancellable: AnyCancellable?
        @Published var dessertResult: Result<[Dessert], Error>? = nil
        
        init() {
            getDesserts()
        }
        
        func getDesserts() {
            guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
                DispatchQueue.main.async {
                    self.dessertResult = .failure(NetworkError.invalidURL)
                }
                return
            }
            
            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                    .map { $0.data }
                    .decode(type: DessertResponse.self, decoder: JSONDecoder())
                    .map { $0.meals.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending } }
                    .sink(receiveCompletion: { [weak self] completion in
                        switch completion {
                        case .failure(let error):
                            print("Network request failed with error: \(error)")
                            DispatchQueue.main.async {
                                self?.dessertResult = .failure(error)
                            }
                        case .finished:
                            break // Do nothing on success
                        }
                    }, receiveValue: { [weak self] desserts in
                        DispatchQueue.main.async {
                            self?.dessertResult = .success(desserts)
                        }
                    })

        }
    }
}
