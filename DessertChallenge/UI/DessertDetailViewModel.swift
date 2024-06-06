//
//  DessertDetailViewModel.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/22/24.
//

import Foundation

extension DessertDetailView {
    
    /* DessertDetailViewModel makes the network request and decodes the json with its custom
     decoding function. I thought it was easier to just write the decoding function here than
     using combine framework like earlier
     */
    class ViewModel: ObservableObject {
        var id: String = ""
        @Published var dessertRecipeResult: Result<DessertRecipe, Error>? = nil
        
        init(id: String) {
            self.id = id
        }
        
        func fetchRecipe() {
            var urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i="
            urlString.append(id)
            print(urlString)
            guard let url = URL(string: urlString) else {
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.dessertRecipeResult = .failure(error)
                    }
                    return
                }
                guard let data = data else {
                    DispatchQueue.main.async {
                        self.dessertRecipeResult = .failure(NetworkError.invalidData)
                    }
                    return
                }
                do {
                    //   let dessertRecipes = try decodeDessertRecipes(from: data)
                    self.decodeRecipe(data: data)
                }
            }
            task.resume()
        }
        
        func decodeRecipe(data: Data) {
            var measurements: [String] = []
            var ingredients: [String] = []
            var instructions: [String] = []
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let meals = jsonObject["meals"] as? [[String: Any]],
                      let ins = meals.first?["strInstructions"] as? String else {
                    throw NetworkError.invalidData
                }
                
                instructions = ins.components(separatedBy: "\r\n").filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
                
                var moreIngredientsToParse = true
                var i = 1
                while moreIngredientsToParse {
                    if let ingredient = meals.first?["strIngredient\(i)"] as? String,
                       let measurement = meals.first?["strMeasure\(i)"] as? String,
                       !ingredient.isEmpty, !measurement.isEmpty {
                        ingredients.append(ingredient)
                        measurements.append(measurement)
                    } else {
                        moreIngredientsToParse = false
                    }
                    i += 1
                }
                
                DispatchQueue.main.async {
                    self.dessertRecipeResult = .success(DessertRecipe(instructions: instructions, ingredients: ingredients, measurements: measurements))
                }
            } catch {
                DispatchQueue.main.async {
                    self.dessertRecipeResult = .failure(error)
                }
            }
        }

    }
}
