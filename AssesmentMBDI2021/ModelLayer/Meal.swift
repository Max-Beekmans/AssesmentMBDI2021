//
//  Meals.swift
//  AssesmentMBDI2021
//
//  Created by Max Beekmans on 2/25/21.
//

import Foundation

struct Meal : Decodable {
    let name : String
    let thumb : String
    let mealId : String
    
    enum CodingKeys : String, CodingKey {
        case name = "strMeal"
        case thumb = "strMealThumb"
        case mealId = "idMeal"
    }
}
