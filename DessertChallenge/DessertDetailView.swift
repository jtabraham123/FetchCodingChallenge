//
//  DessertDetailView.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/22/24.
//

import SwiftUI

struct DessertDetailView: View {
    
    /* Detail view for the dessert item, contains image, title, recipe information
     if the network request fails, there is an error screen that allows you to retry
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
            if (!viewModel.requestFailed) {
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
            else {
                Text("Network request failed: ").padding()
                
                Button("Retry") {
                    viewModel.retryRequest()
                }
                Spacer()
            }
            
        }
    }
}


#Preview {
    DessertDetailView(listItemViewModel: DessertListItemView.ViewModel(urlString: "https://www.themealdb.com/images/media/meals/uryqru1511798039.jpg", dessertTitle: "White chocolate creme brulee"), viewModel: DessertDetailView.ViewModel(id: "52917"))
}

