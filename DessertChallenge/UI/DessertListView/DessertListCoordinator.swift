//
//  DessertListCoordinator.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 6/10/24.
//

import Foundation
import Swinject
import SwiftUI


class DessertListCoordinator: ObservableObject {
    private let resolver: Resolver
    var dessertListViewModel: DessertListView.ViewModel
    @Published var dessertListItemViewModels: [DessertListItemView.ViewModel] = []
    @Published var path = NavigationPath()
    
    
    init(resolver: Resolver) {
        self.resolver = resolver
        self.dessertListViewModel = resolver.resolved(DessertListView.ViewModel.self)
        dessertListViewModel.addDelegate(delegate: self)
    }
    
}

extension DessertListCoordinator: DessertListViewModelDelegate {
    func didRecieveDesserts(_ desserts: [Dessert]) {
        // create viewmodels
        for dessert in desserts {
            DispatchQueue.main.async {
                let dessertListItemViewModel = self.resolver.resolved(DessertListItemView.ViewModel.self, argument:dessert)
                dessertListItemViewModel.addDelegate(delegate: self)
                self.dessertListItemViewModels.append(dessertListItemViewModel)
            }
        }
    }
}

extension DessertListCoordinator: DessertListItemViewModelDelegate {
    func didTapDessertItem(_ source: DessertListItemView.ViewModel) {
        // navigation logic
        // create viewmodel
        let dessertDetailViewModel = self.resolver.resolved(DessertDetailView.ViewModel.self, argument:source.dessert)
        dessertDetailViewModel.getImage()
        dessertDetailViewModel.fetchRecipe()
        // append view model to path
        path.append(dessertDetailViewModel)
        
    }
}
