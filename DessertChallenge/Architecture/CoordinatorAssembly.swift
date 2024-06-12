//
//  CoordinatorAssembly.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 6/10/24.
//


import Foundation
import Swinject

class CoordinatorAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(DessertMainCoordinator.self) { r in
            DessertMainCoordinator(resolver: r)
        }.inObjectScope(.container)
        
        container.register(DessertListCoordinator.self) { r in
            DessertListCoordinator(resolver: r)
        }.inObjectScope(.container)
        
        
    }
}
