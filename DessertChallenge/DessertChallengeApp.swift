//
//  DessertChallengeApp.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/21/24.
//

import SwiftUI

private let appAssembler: AppAssembler = AppAssembler()

@main
struct DessertChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            DessertListView(dessertListCoordinator: appAssembler.resolver.resolved(DessertListCoordinator.self))
        }
    }
}
