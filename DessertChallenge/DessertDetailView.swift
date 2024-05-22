//
//  DessertDetailView.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/22/24.
//

import SwiftUI

struct DessertDetailView: View {
    
    // To have the image and name show up in the detail view, I chose to pass in listItemViewModel
    // here and observe listItemViewModel from this view for simplicity, though a less
    // coupled approach would be to have DessertDetailView view model (this view's view model)
    // observe DessertListItemView view model for image updates and to access the dessert name
    
    @ObservedObject var listItemViewModel: DessertListItemView.ViewModel
    
    @ObservedObject var viewModel: ViewModel // DessertDetailView view model
    
    
    var body: some View {
        VStack {
            if (listItemViewModel.loadedImage != nil) {
                Image(uiImage: listItemViewModel.loadedImage!).resizable()
                    .frame(width: 200, height: 200)
                    .clipShape(Rectangle())
            }
            else { //placeholder while loading in or if errors
                ProgressView().frame(width: 200, height: 200)
            }
            Text(listItemViewModel.dessertTitle).foregroundColor(.black).font(.system(size: 24, weight: .bold, design: .default))
            
        }
    }
}


 #Preview {
     DessertDetailView(listItemViewModel: DessertListItemView.ViewModel(urlString: "https://www.themealdb.com/images/media/meals/uryqru1511798039.jpg", dessertTitle: "White chocolate creme brulee"), viewModel: DessertDetailView.ViewModel(id: "52917"))
 }
 
