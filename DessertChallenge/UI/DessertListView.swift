//
//  DessertListView.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/21/24.
//

import SwiftUI
import Swinject


/* List View of desserts, contains clickable DessertListItemviews when
 the network request is successful, otherwise it shows an error screen
 with a button to retry the request
 */
struct DessertListView: View {
    
    
    var topBarViewModel: TopBarView.ViewModel
    @ObservedObject private var viewModel: ViewModel
    let resolver: Resolver
    
    init(topBarViewModel: TopBarView.ViewModel, viewModel: DessertListView.ViewModel, resolver: Resolver) {
        self.topBarViewModel = topBarViewModel
        self.resolver = resolver
        self.viewModel = viewModel
        self.viewModel.getDesserts()
    }
    
    var body: some View {
        
        switch viewModel.dessertResult {
        case .none:
            ProgressView().frame(width: 400, height: 400)
            Spacer()
        case .success(let desserts):
            NavigationStack {
                List(desserts) { dessert in
                    let dessertListItemViewModel = resolver.resolved(DessertListItemView.ViewModel.self)
                    let hi = dessertListItemViewModel.setValues(stringUrl: dessert.thumbnail, dessertTitle: dessert.name)
                    let dessertDetailViewModel = resolver.resolved(DessertDetailView.ViewModel.self)
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
    DessertListView(topBarViewModel: TopBarView.ViewModel(), viewModel: DessertListView.ViewModel(), resolver: AppAssembler().resolver)
}
