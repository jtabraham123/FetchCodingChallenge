//
//  RepositoryAssembly.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 6/11/24.
//

import Foundation
import Swinject

class RepositoryAssembly: Assembly {
    func assemble(container: Container) {
        
        container.register(InMemoryImageRepository.self) { r in
            InMemoryImageRepository(imageLoadService: r.resolved(ImageLoadService.self))
        }.inObjectScope(.container)
        
    }
}
