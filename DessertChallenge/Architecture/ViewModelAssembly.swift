//
//  ViewModelAssembly.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 6/5/24.
//

import Foundation
import Swinject

class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        container.register(DessertListView.ViewModel.self) { r in
            DessertListView.ViewModel(dessertListService: r.resolved(DessertListService.self))
        }.inObjectScope(.transient)
        
        container.register(DessertListItemView.ViewModel.self) { (r, argument:Dessert)  in
            return DessertListItemView.ViewModel(dessert: argument, imageRepository: r.resolved(InMemoryImageRepository.self))
        }.inObjectScope(.transient)
        
        container.register(DessertDetailView.ViewModel.self) { (r, argument: Dessert) in
            return DessertDetailView.ViewModel(dessert: argument , dessertDetailService: r.resolved(DessertDetailService.self), imageRepository: r.resolved(InMemoryImageRepository.self))
        }.inObjectScope(.transient)
        
        container.register(TopBarView.ViewModel.self) { r in
            TopBarView.ViewModel()
        }.inObjectScope(.transient)
    }
}
