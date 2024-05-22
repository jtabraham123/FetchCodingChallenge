//
//  DessertListView.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/21/24.
//

import SwiftUI

struct DessertListView: View {
    
    @StateObject private var viewModel  = ViewModel()
    
    
    var body: some View {
        List(viewModel.desserts) { dessert in
            DessertListItemView(viewModel: DessertListItemView.ViewModel(urlString: dessert.thumbnail, dessertTitle: dessert.name))
        }
    }
}

#Preview {
    DessertListView()
}
