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
                case .failure(let error):
                    Text("Failed to load image: \(error.localizedDescription)")
                        .frame(width: 50, height: 50)
                }
                Text(viewModel.dessert.name).font(.headline).foregroundColor(.black)
            }
        }
    }
    
}

/*
 
 #Preview {
 DessertListItemView(viewModel: DessertListItemView.ViewModel(stringUrl: "https://www.themealdb.com/images/media/meals/uryqru1511798039.jpg", dessertTitle: "White chocolate creme brulee", imageLoadService: ImageLoadService()))
 }
 */
