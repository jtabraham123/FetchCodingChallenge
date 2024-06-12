//
//  DessertMainCoordinator.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 6/10/24.
//

import Foundation
import Swinject

class DessertMainCoordinator {
    private let resolver: Resolver
    
    var topBarViewModel: TopBarView.ViewModel
    var dessertListCoordinator: DessertListCoordinator
    
    
    init(resolver: Resolver) {
        self.resolver = resolver
        topBarViewModel = resolver.resolved(TopBarView.ViewModel.self)
        dessertListCoordinator = resolver.resolved(DessertListCoordinator.self)
    }
}
