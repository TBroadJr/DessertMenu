//
//  RecipeID.swift
//  DessertMenu
//
//  Created by Tornelius Broadwater, Jr on 11/22/22.
//

import Foundation

struct RecipeID: Codable {
    var meals: [Meal]
}

struct Meal: Codable {
    var idMeal: String
}
