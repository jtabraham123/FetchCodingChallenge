//
//  DessertListViewModel.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/21/24.
//

import Foundation
import Combine

// DessertListViewModel makes the api request for dessert items upon initialization and upon retry button click
extension DessertListView {
    class ViewModel: ObservableObject {
        
        private var cancellable: AnyCancellable?
        @Published var desserts: [Dessert] = []
        @Published var requestFailed = false
        
        init() {
            getDesserts()
        }
        
        func retryRequest() {
            requestFailed = false
            // Retry the network request when the button is tapped
            getDesserts()
        }
        
        func getDesserts() {
            guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
                return
            }
            
            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                    .map { $0.data }
                    .decode(type: DessertResponse.self, decoder: JSONDecoder())
                    .map { $0.meals }
                    .receive(on: DispatchQueue.main)
                    .catch { error -> Just<[Dessert]> in
                            print("Network request failed with error: \(error)")
                        self.requestFailed = true
                            // Handle the error, e.g., show an alert or log the error
                            return Just([])
                        }
                    .assign(to: \.desserts, on: self)

        }
    }
}
