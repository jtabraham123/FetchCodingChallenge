//
//  DessertListView.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/21/24.
//

import SwiftUI

struct DessertListView: View {
    
    
    var topBarViewModel: TopBarView.ViewModel
    
    @StateObject private var viewModel  = ViewModel()
    
    
    
    var body: some View {
        NavigationStack {
            List(viewModel.desserts) { dessert in
                let dessertListItemViewModel = DessertListItemView.ViewModel(urlString: dessert.thumbnail, dessertTitle: dessert.name)
                let dessertDetailViewModel = DessertDetailView.ViewModel(id: dessert.id)
                let dessertDetailView = DessertDetailView(listItemViewModel: dessertListItemViewModel, viewModel: dessertDetailViewModel).onAppear {
                    dessertDetailViewModel.fetchRecipe()
                    topBarViewModel.isVisible = false
                    print("changing views")
                }
                NavigationLink(destination: dessertDetailView) {
                    DessertListItemView(viewModel: dessertListItemViewModel)
                    }
                }.onAppear {
                    topBarViewModel.isVisible = true
                    print("back to normal views")
                }
            }
        }
    }



#Preview {
    DessertListView(topBarViewModel: TopBarView.ViewModel())
}
