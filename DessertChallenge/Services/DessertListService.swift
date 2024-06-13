//
//  DessertListService.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 6/6/24.
//

import Foundation
import Combine

protocol DessertListServiceProtocol {
    func fetchDesserts(completion: @escaping (Result<[Dessert], Error>) -> Void)
}

// Loads dessert options from themealdb.com
class DessertListService: DessertListServiceProtocol {
    private var cancellable: AnyCancellable?

    func fetchDesserts(completion: @escaping (Result<[Dessert], Error>) -> Void) {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: DessertResponse.self, decoder: JSONDecoder())
            .map { $0.meals.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending } }
            .sink(receiveCompletion: { result in
                switch result {
                case .failure(let error):
                    completion(.failure(error))
                case .finished:
                    break
                }
            }, receiveValue: { desserts in
                completion(.success(desserts))
            })
    }
}
