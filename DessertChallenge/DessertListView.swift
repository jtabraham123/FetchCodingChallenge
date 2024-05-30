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
        
        switch viewModel.dessertResult {
        case .none:
            ProgressView().frame(width: 400, height: 400)
            Spacer()
        case .success(let desserts):
            NavigationStack {
                List(desserts) { dessert in
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
        case .failure(let error):
            Text("Failed to load desserts: \(error.localizedDescription)")
                .frame(width: 200, height: 200)
        }
    }
}



#Preview {
    DessertListView(topBarViewModel: TopBarView.ViewModel())
}
