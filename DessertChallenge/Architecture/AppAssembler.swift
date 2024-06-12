//
//  AppAssembler.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 6/5/24.
//

import Foundation
import Swinject

class AppAssembler {
    private let assembler: Assembler
    
    var resolver: Resolver { self.assembler.resolver }
    
    init() {
        self.assembler = Assembler([
            CoordinatorAssembly(),
            ServiceAssembly(),
            RepositoryAssembly(),
            ViewModelAssembly()
        ])
    }
}
