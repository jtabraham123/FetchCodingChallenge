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
    @ObservedObject var dessertListCoordinator: DessertListCoordinator
    
    init(topBarViewModel: TopBarView.ViewModel, dessertListCoordinator: DessertListCoordinator) {
        self.topBarViewModel = topBarViewModel
        self.dessertListCoordinator = dessertListCoordinator
        self.viewModel = dessertListCoordinator.dessertListViewModel
        self.viewModel.getDesserts()
    }
    
    var body: some View {
        
        switch viewModel.dessertResult {
        case .none:
            ProgressView().frame(width: 400, height: 400)
            Spacer()
        case .success(_):
            // TODO: Fix this logic in view issue
            NavigationStack(path: self.$dessertListCoordinator.path) {
                List(dessertListCoordinator.dessertListItemViewModels) { listItemViewModel in
                    DessertListItemView(viewModel: listItemViewModel)
                }
                .navigationDestination(for: DessertDetailView.ViewModel.self) { detailViewModel in
                    DessertDetailView(viewModel: detailViewModel)
                }
            }
        case .failure(let error):
            Text("Failed to load desserts: \(error.localizedDescription)")
                .frame(width: 200, height: 200)
        }
    }
}


/*
 #Preview {
     DessertListView(topBarViewModel: TopBarView.ViewModel(), viewModel: DessertListView.ViewModel(dessertListService: DessertListService()), resolver: AppAssembler().resolver)
 }

 */
