//
//  Ingredients.swift
//  AssesmentMBDI2021
//
//  Created by Max Beekmans on 2/25/21.
//

import Foundation

struct Ingredient : Decodable {
    let id : String
    let name : String
    let description : String?
    let type : String?
    
    enum CodingKeys : String, CodingKey {
        case id = "idIngredient"
        case name = "strIngredient"
        case description = "strDescription"
        case type = "strType"
    }
}
