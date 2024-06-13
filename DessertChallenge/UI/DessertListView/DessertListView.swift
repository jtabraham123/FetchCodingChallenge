//
//  DessertListView.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/21/24.
//

import SwiftUI
import Swinject


/* Main view: List View of desserts, contains clickable DessertListItemviews when
 the network request is successful, otherwise it shows an error screen
 with a RetryButtonView to retry the request
 */
struct DessertListView: View {
    
    @ObservedObject private var viewModel: ViewModel
    @ObservedObject var dessertListCoordinator: DessertListCoordinator
    
    init(dessertListCoordinator: DessertListCoordinator) {
        self.dessertListCoordinator = dessertListCoordinator
        self.viewModel = dessertListCoordinator.dessertListViewModel
        self.viewModel.getDesserts(retry: false)
    }
    
    var body: some View {
        switch viewModel.dessertResult {
        case .none:
            TopBarView()
            ProgressView().frame(width: 400, height: 400)
            Spacer()
        case .success(_):
            NavigationStack(path: self.$dessertListCoordinator.path) {
                TopBarView()
                List(dessertListCoordinator.dessertListItemViewModels) { listItemViewModel in
                    DessertListItemView(viewModel: listItemViewModel)
                }
                .navigationDestination(for: DessertDetailView.ViewModel.self) { detailViewModel in
                    DessertDetailView(viewModel: detailViewModel)
                }
            }
        case .failure(let error):
            VStack {
                TopBarView()
                Text("Failed to load desserts: \(error.localizedDescription)")
                    .frame(width: 200, height: 200)
                Button(action: {
                    self.viewModel.getDesserts(retry: true)
                }) {
                    RetryButtonView()
                }
                Spacer()
            }
        }
    }
}


/*
 #Preview {
 DessertListView(topBarViewModel: TopBarView.ViewModel(), viewModel: DessertListView.ViewModel(dessertListService: DessertListService()), resolver: AppAssembler().resolver)
 }
 
 */
