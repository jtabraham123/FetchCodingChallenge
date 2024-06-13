//
//  DessertListItemView.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/22/24.
//

import SwiftUI

// Presents a dessert item with both an image and title

struct DessertListItemView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    
    var body: some View {
        Button (action: viewModel.tappedDessertItem) {
            HStack() {
                switch viewModel.loadResult {
                case .none:
                    ProgressView().frame(width: 50, height: 50)
                case .success(let image):
                    Image(uiImage: image).resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Rectangle())
                case .failure(_):
                    Button(action: {
                        self.viewModel.getImage(retry: true)
                    }) {
                        Image(systemName: "arrow.clockwise.circle")
                            .font(.title)
                            .foregroundColor(.blue)
                            .padding()
                            .background(Color.white)
                            .clipShape(Rectangle())
                            .frame(width: 50, height: 50)
                    }
                }
                Text(viewModel.dessert.name).font(.headline).foregroundColor(.black)
            }
        }
    }
    
}

/*
#Preview {
    DessertListItemView(viewModel: DessertListItemView.ViewModel(dessert: Dessert(id: "fdd", name: "fdf", thumbnail: "afasd"), imageRepository: AppAssembler().resolver.resolved(InMemoryImageRepository.self)))
}
*/
