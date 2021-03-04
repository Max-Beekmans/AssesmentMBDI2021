//
//  MealDetail.swift
//  AssesmentMBDI2021
//
//  Created by Max Beekmans on 3/2/21.
//

import Foundation

struct MealDetail : Decodable {
    let name : String
    let thumb : String
    let mealId : String
    let category : String
    let area : String
    let instructions : String
    
    enum CodingKeys : String, CodingKey {
        case name = "strMeal"
        case thumb = "strMealThumb"
        case mealId = "idMeal"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
    }
}
