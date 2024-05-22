//
//  DessertListView.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/21/24.
//

import SwiftUI

struct DessertListView: View {
    
    @ObservedObject private var viewModel  = ViewModel()
    
    
    var body: some View {
        VStack(spacing: 0) {
            if (viewModel.showTopBar) {
                TopBarView()
                Spacer()
            }
            NavigationStack {
                List(viewModel.desserts) { dessert in
                    let dessertListItemViewModel = DessertListItemView.ViewModel(urlString: dessert.thumbnail, dessertTitle: dessert.name)
                    let dessertDetailViewModel = DessertDetailView.ViewModel(id: dessert.id)
                    let dessertDetailView = DessertDetailView(listItemViewModel: dessertListItemViewModel, viewModel: dessertDetailViewModel).onAppear {
                        dessertDetailViewModel.fetchRecipe()
                        viewModel.showTopBar = false
                    }
                    NavigationLink(destination: dessertDetailView) {
                        DessertListItemView(viewModel: dessertListItemViewModel)
                        }
                    }.onAppear {
                        viewModel.showTopBar = true
                    }
                }
            }
        }
    }



#Preview {
    DessertListView()
}
