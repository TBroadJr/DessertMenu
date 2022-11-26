//
//  Recipes.swift
//  DessertMenu
//
//  Created by Tornelius Broadwater, Jr on 11/22/22.
//

import UIKit

struct Recipes: Codable {
    var meals: [Recipe]
}

struct Recipe: Codable {
    var name: String
    var instructions: String
    var imageURL: String
    private var ingredient1: String
    private var ingredient2: String
    private var ingredient3: String
    private var ingredient4: String
    private var ingredient5: String
    private var ingredient6: String
    private var ingredient7: String
    private var ingredient8: String
    private var ingredient9: String
    private var ingredient10: String
    private var ingredient11: String
    private var ingredient12: String
    private var ingredient13: String
    private var ingredient14: String
    private var ingredient15: String
    private var ingredient16: String?
    private var ingredient17: String?
    private var ingredient18: String?
    private var ingredient19: String?
    private var ingredient20: String?
    private var measure1: String
    private var measure2: String
    private var measure3: String
    private var measure4: String
    private var measure5: String
    private var measure6: String
    private var measure7: String
    private var measure8: String
    private var measure9: String
    private var measure10: String
    private var measure11: String
    private var measure12: String
    private var measure13: String
    private var measure14: String
    private var measure15: String
    private var measure16: String?
    private var measure17: String?
    private var measure18: String?
    private var measure19: String?
    private var measure20: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case instructions = "strInstructions"
        case imageURL = "strMealThumb"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
        case ingredient6 = "strIngredient6"
        case ingredient7 = "strIngredient7"
        case ingredient8 = "strIngredient8"
        case ingredient9 = "strIngredient9"
        case ingredient10 = "strIngredient10"
        case ingredient11 = "strIngredient11"
        case ingredient12 = "strIngredient12"
        case ingredient13 = "strIngredient13"
        case ingredient14 = "strIngredient14"
        case ingredient15 = "strIngredient15"
        case ingredient16 = "strIngredient16"
        case ingredient17 = "strIngredient17"
        case ingredient18 = "strIngredient18"
        case ingredient19 = "strIngredient19"
        case ingredient20 = "strIngredient20"
        case measure1 = "strMeasure1"
        case measure2 = "strMeasure2"
        case measure3 = "strMeasure3"
        case measure4 = "strMeasure4"
        case measure5 = "strMeasure5"
        case measure6 = "strMeasure6"
        case measure7 = "strMeasure7"
        case measure8 = "strMeasure8"
        case measure9 = "strMeasure9"
        case measure10 = "strMeasure10"
        case measure11 = "strMeasure11"
        case measure12 = "strMeasure12"
        case measure13 = "strMeasure13"
        case measure14 = "strMeasure14"
        case measure15 = "strMeasure15"
        case measure16 = "strMeasure16"
        case measure17 = "strMeasure17"
        case measure18 = "strMeasure18"
        case measure19 = "strMeasure19"
        case measure20 = "strMeasure20"
    }
            
    var ingredientsArray: [String] {
        var array = [String]()
        
        func addItems(measures: [String], ingredients: [String], array: inout [String]) {
            var measurementsArray = [String]()
            var ingredientsArray = [String]()
            var num = 0
            
            for i in measures {
                if i != " " && i != ""{
                    measurementsArray.append(i)
                }
            }
            
            for i in ingredients {
                if i != " " && i != "" {
                    ingredientsArray.append(i)
                }
            }
            
            while num < measurementsArray.count {
                if measures[num].contains("To") || measures[num].contains("to") {
                    let item = ingredientsArray[num] + " " + measurementsArray[num]
                    array.append(item)
                    num += 1
                } else {
                    let item = measures[num] + " " + ingredientsArray[num]
                    array.append(item)
                    num += 1
                }
            }
        }
        
        addItems(
            measures: [
                measure1,
                measure2,
                measure3,
                measure4,
                measure5,
                measure6,
                measure7,
                measure8,
                measure9,
                measure10,
                measure11,
                measure12,
                measure13,
                measure14,
                measure15,
                measure16 ?? "",
                measure17 ?? "",
                measure18 ?? "",
                measure19 ?? "",
                measure20 ?? "",
            ],
                 ingredients: [
                 ingredient1,
                 ingredient2,
                 ingredient3,
                 ingredient4,
                 ingredient5,
                 ingredient6,
                 ingredient7,
                 ingredient8,
                 ingredient9,
                 ingredient10,
                 ingredient11,
                 ingredient12,
                 ingredient13,
                 ingredient14,
                 ingredient15,
                 ingredient16 ?? "",
                 ingredient17 ?? "",
                 ingredient18 ?? "",
                 ingredient19 ?? "",
                 ingredient20 ?? "",
                 ], array: &array)
        
        return array
    }
}
