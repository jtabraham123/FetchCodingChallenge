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
        var urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i="
        
        
        init(id: String) {
            self.id = id
        }
        
        func fetchRecipe() {
            urlString.append(id)
            print(urlString)
            guard let url = URL(string: urlString) else {
                return
            }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                print("got a response")
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
            task.resume()
        }
        
        
        func decodeRecipe(data: Data) {
            do {
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    if let meals = jsonObject["meals"] as? [[String: Any]] {
                        if let instructions = meals[0]["strInstructions"] as? String {
                            print("Instructions: \(instructions)")
                        } else {
                            print("Instructions not found")
                        }
                        for i in 1...20 {
                            if let ingredient = meals[0]["strIngredient\(i)"] as? String,
                               let measurement = meals[0]["strMeasure\(i)"] as? String {
                                if !ingredient.isEmpty && !measurement.isEmpty {
                                    print("Ingredient \(i): \(ingredient), Measurement \(i): \(measurement)")
                                }
                            }
                            
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
        }
    }
}
