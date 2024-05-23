//
//  DessertMainView.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/23/24.
//

import SwiftUI


// Main view, consists of top bar and List of desserts views
struct DessertMainView: View {
    var body: some View {
        let topBarViewModel = TopBarView.ViewModel()
        TopBarView(viewModel: topBarViewModel)
        Spacer()
        DessertListView(topBarViewModel: topBarViewModel)
    }
}

#Preview {
    DessertMainView()
}
