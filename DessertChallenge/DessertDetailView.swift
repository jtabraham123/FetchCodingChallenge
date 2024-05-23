//
//  DessertDetailView.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/22/24.
//

import SwiftUI

struct DessertDetailView: View {
    
    /* To have the image and name show up in the detail view, I chose to pass in listItemViewModel
     here and observe listItemViewModel from this view for simplicity, though a less
     coupled approach would be to have DessertDetailView view model (this view's view model)
     observe DessertListItemView view model for image updates and to access the dessert name
     */
    
    @ObservedObject var listItemViewModel: DessertListItemView.ViewModel
    
    @ObservedObject var viewModel: ViewModel // DessertDetailView view model
    
    let columns: [GridItem] = [
            GridItem(.adaptive(minimum: 100))
        ]
    
    
    var body: some View {
        VStack {
            if (listItemViewModel.loadedImage != nil) {
                Image(uiImage: listItemViewModel.loadedImage!).resizable()
                    .frame(width: 200, height: 150)
                    .clipShape(Rectangle())
            }
            else { //placeholder while loading in or if errors
                ProgressView().frame(width: 200, height: 150)
            }
            Text(listItemViewModel.dessertTitle).foregroundColor(.black).font(.system(size: 24, weight: .bold, design: .default))

            if (viewModel.dessertRecipe != nil) {
                ScrollView {
                    Text("Ingredients: ").foregroundColor(.black).font(.system(size: 20, weight: .light, design: .default))
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(Array(viewModel.dessertRecipe!.ingredients.enumerated()), id: \.offset) { index, item in
                            Text(viewModel.dessertRecipe!.measurements[index] + " " + item)
                                .frame(minWidth: 100, minHeight: 100)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    Text("Instructions: ").foregroundColor(.black).font(.system(size: 20, weight: .light, design: .default))
                    ForEach(Array(viewModel.dessertRecipe!.instructions.enumerated()), id: \.offset) { index, instruction in
                            Spacer(minLength: 20.0)
                        HStack {
                                Text(String(index+1) +  ". " + instruction).fixedSize(horizontal: false, vertical: true).frame(alignment: .leading)
                                Spacer()
                            }
                    }
                }
            }
        }
    }
}


 #Preview {
     DessertDetailView(listItemViewModel: DessertListItemView.ViewModel(urlString: "https://www.themealdb.com/images/media/meals/uryqru1511798039.jpg", dessertTitle: "White chocolate creme brulee"), viewModel: DessertDetailView.ViewModel(id: "52917"))
 }
 
