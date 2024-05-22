//
//  DessertListItemView.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/22/24.
//

import SwiftUI

struct DessertListItemView: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        HStack() {
            if (viewModel.loadedImage != nil) {
                Image(uiImage: viewModel.loadedImage!).resizable()
                .frame(width: 50, height: 50)
                .clipShape(Rectangle())
            }
            else { //placeholder while loading in or if errors
                ProgressView().frame(width: 50, height: 50)
            }
            Text(viewModel.dessertTitle).font(.headline)
        }
    }
}

#Preview {
    DessertListItemView(viewModel: DessertListItemView.ViewModel(urlString: "https://www.themealdb.com/images/media/meals/uryqru1511798039.jpg", dessertTitle: "White chocolate creme brulee"))
}
