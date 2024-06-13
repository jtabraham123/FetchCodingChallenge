//
//  Resolver+Resolved.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 6/5/24.
//

import Foundation
import Swinject

// extension class to make resolving with swinject easier
extension Resolver {
    @inlinable
    func resolved<Service>(_ serviceType: Service.Type) -> Service {
        guard let service = resolve(serviceType) else {
            fatalError("\(serviceType) is required for this app. Please register \(serviceType) in an Assembly.")
        }
        return service
    }
    
    func resolved<Service, Arg1>(_ serviceType: Service.Type, argument: Arg1) -> Service {
        guard let service = resolve(serviceType, argument: argument) else {
            fatalError("\(serviceType) is required for this app. Please register \(serviceType) in an Assembly.")
        }
        return service
    }
    
}
