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
    let resolver: Resolver
    
    var body: some View {
        let topBarViewModel = resolver.resolved(TopBarView.ViewModel.self)
        TopBarView(viewModel: topBarViewModel)
        Spacer()
        let dessertListViewModel = resolver.resolved(DessertListView.ViewModel.self)
        DessertListView(topBarViewModel: topBarViewModel, viewModel: dessertListViewModel, resolver: resolver)
    }
}

#Preview {
    DessertMainView(resolver: AppAssembler().resolver)
}
