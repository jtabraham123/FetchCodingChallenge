//
//  DesssertDetailService.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 6/10/24.
//

import Foundation
import UIKit


protocol DessertDetailServiceProtocol {
    func fetchDessertDetails(idString: String, completion: @escaping (Result<DessertRecipe, Error>) -> Void)
}

class DessertDetailService: DessertDetailServiceProtocol {
    
    func fetchDessertDetails(idString: String, completion: @escaping (Result<DessertRecipe, Error>) -> Void) {
        var urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i="
        urlString.append(idString)
        
        guard let url = URL(string: urlString) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            do {
                //   let dessertRecipes = try decodeDessertRecipes(from: data)
                completion(self.decodeRecipe(data: data))
            }
        }
        task.resume()
    }
    
    private func decodeRecipe(data: Data) -> Result<DessertRecipe, Error> {
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
            
            return .success(DessertRecipe(instructions: instructions, ingredients: ingredients, measurements: measurements))
        } catch {
            return .failure(error)
        }
    }
}
