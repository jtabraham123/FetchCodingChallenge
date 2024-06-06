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
            DessertListView.ViewModel()
        }.inObjectScope(.transient)
        
        container.register(DessertListItemView.ViewModel.self) { (r, arguments:[String])  in
            
            guard arguments.count == 2 else {
                fatalError("Invalid arguments provided when resolving DessertListItemView.ViewModel.")
            }
            DessertListItemView.ViewModel(stringUrl: arguments.first, dessertTitle: arguments.last)
        }.inObjectScope(.transient)
        
        container.register(DessertDetailView.ViewModel.self) { r in
            DessertDetailView.ViewModel()
        }.inObjectScope(.transient)
        
        container.register(TopBarView.ViewModel.self) { r in
            TopBarView.ViewModel()
        }.inObjectScope(.transient)
    }
}
