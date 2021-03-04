//
//  Ingredient.swift
//  AssesmentMBDI2021
//
//  Created by Max Beekmans on 2/25/21.
//

import Foundation

struct IngredientsMealList : Decodable {
    var meals : [Ingredient]
}

struct MealList : Decodable {
    var meals: [Meal]
}

struct MealDetailList : Decodable {
    var meals: [MealDetail]
}
