//
//  DessertModels.swift
//  DessertChallenge
//
//  Created by Jack Abraham on 5/21/24.
//

import Foundation

// Data Models
struct Dessert: Codable, Identifiable {
    let id: String
    let name: String
    let thumbnail: String

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnail = "strMealThumb"
    }
}

struct DessertResponse: Codable {
    let meals: [Dessert]
    enum CodingKeys: String, CodingKey {
            case meals = "meals"
        }
}
