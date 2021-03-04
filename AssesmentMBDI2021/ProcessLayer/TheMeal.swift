//
//  TheMeal.swift
//  AssesmentMBDI2021
//
//  Created by Max Beekmans on 2/25/21.
//

import Foundation

class TheMeal {
    // Get list of ingredients available in the API
    func getIngredientList(completion: @escaping(([Ingredient]?) -> ())) {
        let apiUrl = "https://www.themealdb.com/api/json/v1/1/list.php?i=list"
        
        if let url = URL(string: apiUrl) {

            let task = URLSession.shared.dataTask(with: url) { data, response, error in

                if let receivedData = data {
                    Swift.print("\(receivedData.description)")
                    
                    do {
                        let decoder = JSONDecoder()
                        let ingredientData = try decoder.decode(IngredientsMealList.self, from: receivedData)
                        let ingredientsList = ingredientData.meals;
                        completion(ingredientsList)
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context)  {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch {
                        print("error: ", error)
                    }
                }
            }

            task.resume()
        }
    }
    
    // Get list of meals with chicken_breast as ingredient
    func getMealList(completion: @escaping(([Meal]?) -> ())) {
        let apiUrl = "https://www.themealdb.com/api/json/v1/1/filter.php?i=chicken_breast"
        
        if let url = URL(string: apiUrl) {

            let task = URLSession.shared.dataTask(with: url) { data, response, error in

                if let receivedData = data {
                    Swift.print("\(receivedData.description)")
                    
                    do {
                        let decoder = JSONDecoder()
                        let mealsData = try decoder.decode(MealList.self, from: receivedData)
                        let mealsList = mealsData.meals;
                        completion(mealsList)
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context)  {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch {
                        print("error: ", error)
                    }
                }
            }

            task.resume()
        }
    }
    
    //Get specific meal information
    func getMealDetail(id: String, completion: @escaping((MealDetail?) -> ())) {
        let apiUrl = "https://www.themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        
        if let url = URL(string: apiUrl) {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let receivedData = data {
                    Swift.print("\(receivedData.description)")
                    
                    do {
                        let decoder = JSONDecoder()
                        let mealDetailData = try decoder.decode(MealDetailList.self, from: receivedData)
                        let mealDetail = mealDetailData.meals[0]
                        completion(mealDetail)
                    } catch let DecodingError.dataCorrupted(context) {
                        print(context)
                    } catch let DecodingError.keyNotFound(key, context) {
                        print("Key '\(key)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.valueNotFound(value, context) {
                        print("Value '\(value)' not found:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch let DecodingError.typeMismatch(type, context)  {
                        print("Type '\(type)' mismatch:", context.debugDescription)
                        print("codingPath:", context.codingPath)
                    } catch {
                        print("error: ", error)
                    }
                }
            }
            
            task.resume()
        }
    }
}
