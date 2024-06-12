//
//  DessertMainView.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/23/24.
//

import SwiftUI
import Swinject


// Main view, consists of top bar and List of desserts views
struct DessertMainView: View {
    var coordinator: DessertMainCoordinator
    
    var body: some View {
        TopBarView(viewModel: self.coordinator.topBarViewModel)
        Spacer()
        DessertListView(topBarViewModel: self.coordinator.topBarViewModel, dessertListCoordinator: self.coordinator.dessertListCoordinator)
    }
}

#Preview {
    DessertMainView(coordinator: AppAssembler().resolver.resolved(DessertMainCoordinator.self))
}
