//
//  DessertListView.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/21/24.
//

import SwiftUI


/* List View of desserts, contains clickable DessertListItemviews when
 the network request is successful, otherwise it shows an error screen
 with a button to retry the request
 */
struct DessertListView: View {
    
    
    var topBarViewModel: TopBarView.ViewModel
    
    @StateObject private var viewModel  = ViewModel()
    
    
    
    var body: some View {
        if (!viewModel.requestFailed) {
            NavigationStack {
                List(viewModel.desserts) { dessert in
                    let dessertListItemViewModel = DessertListItemView.ViewModel(urlString: dessert.thumbnail, dessertTitle: dessert.name)
                    let dessertDetailViewModel = DessertDetailView.ViewModel(id: dessert.id)
                    let dessertDetailView = DessertDetailView(listItemViewModel: dessertListItemViewModel, viewModel: dessertDetailViewModel).onAppear {
                        dessertDetailViewModel.fetchRecipe()
                        topBarViewModel.isVisible = false
                    }
                    NavigationLink(destination: dessertDetailView) {
                        DessertListItemView(viewModel: dessertListItemViewModel)
                    }
                }.onAppear {
                    topBarViewModel.isVisible = true
                }
            }
        }
        else {
            Text("Network request failed: ")
                .padding()
            Button("Retry") {
                viewModel.retryRequest()
            }
            Spacer()
        }
    }
}



#Preview {
    DessertListView(topBarViewModel: TopBarView.ViewModel())
}
