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
                VStack {
                    Text("Failed to load image: \(error.localizedDescription)")
                        .frame(width: 200, height: 100)
                    Button(action: {
                        self.viewModel.getImage(retry: true)
                    }) {
                        RetryButtonView()
                    }
                }
            }
            
            Text(viewModel.dessert.name).foregroundColor(.black).font(.system(size: 24, weight: .bold, design: .default))
            
            switch viewModel.dessertRecipeResult {
            case .none:
                ProgressView().frame(width: 200, height: 150)
            case .success(let dessertRecipe):
                ScrollView {
                    Text("Ingredients: ").foregroundColor(.black).font(.system(size: 20, weight: .light, design: .default))
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.ingredientsText, id: \.self) { ingredient in
                            Text(ingredient)
                                .frame(minWidth: 100, minHeight: 100)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding()
                    Text("Instructions: ").foregroundColor(.black).font(.system(size: 20, weight: .light, design: .default))
                    ForEach(viewModel.instructionsText, id: \.self) { instruction in
                        Spacer(minLength: 20.0)
                        HStack {
                            Text(instruction).fixedSize(horizontal: false, vertical: true).frame(alignment: .leading)
                            Spacer()
                        }
                    }
                }
            case .failure(let error):
                VStack {
                    Text("Failed to load Recipe: \(error.localizedDescription)")
                        .frame(width: 200, height: 150)
                    Button(action: {
                        self.viewModel.fetchRecipe(retry: true)
                    }) {
                        RetryButtonView()
                    }
                }
            }
            
            
        }
    }
}



#Preview {
    DessertDetailView(viewModel: AppAssembler().resolver.resolved(DessertDetailView.ViewModel.self, argument: Dessert(id: "fsfd", name: "adffd", thumbnail: "afdfd")))
}


