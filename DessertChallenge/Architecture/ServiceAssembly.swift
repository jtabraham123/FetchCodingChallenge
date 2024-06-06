//
//  ServiceAssembly.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 6/6/24.
//

import Foundation
import Swinject

class ServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(DessertListService.self) { r in
          DessertListService()
        }.inObjectScope(.container)
    }
}
