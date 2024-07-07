//
//  TransformObjects.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 7/6/24.
//

import Foundation

extension DessertRecipe {
    func formattedIngredients() -> [String] {
            return zip(measurements, ingredients).map { "\($0.0) \($0.1)" }
        }
    func formattedInstructions() -> [String] {
            return instructions.enumerated().map { "\($0 + 1). \($1)" }
        }
}
