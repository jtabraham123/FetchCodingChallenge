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
        
        container.register(DessertListCoordinator.self) { r in
            DessertListCoordinator(resolver: r)
        }.inObjectScope(.container)
        
        
    }
}
