//
//  DessertDetailViewModel.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/22/24.
//

import Foundation

extension DessertDetailView {
    
    class ViewModel: ObservableObject {
        let id: String
        @Published var dessertRecipe: DessertRecipe? = nil
        
        
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
                        return
                    }
                    guard let data = data else {
                        return
                    }
                    do {
                     //   let dessertRecipes = try decodeDessertRecipes(from: data)
                        self.decodeRecipe(data: data)
                    } catch {
                        
                    }
                }
            if (dessertRecipe == nil) {
                task.resume()
            }
        }
        
        // TODO: handle errors
        func decodeRecipe(data: Data) {
            var measurements: [String] = []
            var ingredients: [String] = []
            var instructions: [String] = []
            do {
                print(id)
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let meals = jsonObject["meals"] as? [[String: Any]] {
                        if let ins = meals[0]["strInstructions"] as? String {
                            instructions = ins.components(separatedBy: "\r\n").filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
                        } else {
                            print("error parsing")
                        }
                        var moreIngredientsToParse = true
                        var i = 1
                        while (moreIngredientsToParse) {
                            if let ingredient = meals[0]["strIngredient\(i)"] as? String,
                               let measurement = meals[0]["strMeasure\(i)"] as? String {
                                if !ingredient.isEmpty && !measurement.isEmpty {
                                    print("Ingredient \(i): \(ingredient), Measurement \(i): \(measurement)")
                                    ingredients.append(ingredient)
                                    measurements.append(measurement)
                                }
                            }
                            else {
                                moreIngredientsToParse = false
                            }
                            i = i + 1
                        }
                    }
                    else {
                        print("error parsing2")
                    }
                }
                else {
                    print("error parsing1")
                }
            }
            catch {
                print("error parsing JSON")
            }
            DispatchQueue.main.async {
                self.dessertRecipe = DessertRecipe(instructions: instructions, ingredients: ingredients, measurements: measurements)
            }
        }
    }
}
