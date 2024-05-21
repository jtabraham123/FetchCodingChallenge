//
//  DessertViewModel.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/21/24.
//

import Foundation
import Combine


extension DessertView {
    class ViewModel: ObservableObject {
        var currentTab = 0
        private var cancellable: AnyCancellable?
        @Published var desserts: [Dessert] = []
        
        func getDesserts() {
            guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
                return
            }
            
            cancellable = URLSession.shared.dataTaskPublisher(for: url)
                    .map { $0.data }
                    .decode(type: DessertResponse.self, decoder: JSONDecoder())
                    .map { $0.meals }
                    .receive(on: DispatchQueue.main)
                    .catch { _ in Just([]) }
                    .assign(to: \.desserts, on: self)

        }
    }
}
