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
    
    @ObservedObject var viewModel: ViewModel // DessertDetailView view model
    
    let columns: [GridItem] = [
        GridItem(.adaptive(minimum: 100))
    ]
    
    
    var body: some View {
        VStack {
            
            switch viewModel.imageResult {
            case .none:
                ProgressView().frame(width: 200, height: 150)
            case .success(let image):
                Image(uiImage: image).resizable()
                    .frame(width: 200, height: 150)
                    .clipShape(Rectangle())
            case .failure(let error):
                Text("Failed to load image: \(error.localizedDescription)")
                    .frame(width: 200, height: 150)
            }
            
            Text(viewModel.dessert.name).foregroundColor(.black).font(.system(size: 24, weight: .bold, design: .default))
            
            switch viewModel.dessertRecipeResult {
            case .none:
                ProgressView().frame(width: 200, height: 150)
            case .success(let dessertRecipe):
                ScrollView {
                    Text("Ingredients: ").foregroundColor(.black).font(.system(size: 20, weight: .light, design: .default))
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(Array(dessertRecipe.ingredients.enumerated()), id: \.offset) { index, item in
                            Text(dessertRecipe.measurements[index] + " " + item)
                                .frame(minWidth: 100, minHeight: 100)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    Text("Instructions: ").foregroundColor(.black).font(.system(size: 20, weight: .light, design: .default))
                    ForEach(Array(dessertRecipe.instructions.enumerated()), id: \.offset) { index, instruction in
                        Spacer(minLength: 20.0)
                        HStack {
                            Text(String(index+1) +  ". " + instruction).fixedSize(horizontal: false, vertical: true).frame(alignment: .leading)
                            Spacer()
                        }
                    }
                }
            case .failure(let error):
                Text("Failed to load Recipe: \(error.localizedDescription)")
                    .frame(width: 200, height: 150)
            }
            
            
        }
    }
}

/*
 #Preview {
 DessertDetailView(listItemViewModel: DessertListItemView.ViewModel(stringUrl: "https://www.themealdb.com/images/media/meals/uryqru1511798039.jpg", dessertTitle: "White chocolate creme brulee", imageLoadService: ImageLoadService()), viewModel: DessertDetailView.ViewModel(id: "52917", dessertDetailService: DessertDetailService()))
 }
 
 */
