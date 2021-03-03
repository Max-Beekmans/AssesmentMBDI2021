//
//  ViewController.swift
//  AssesmentMBDI2021
//
//  Created by Max Beekmans on 2/25/21.
//

import UIKit

class MealListController : UITableViewController {
    
    var mealList = [Meal]()
    var theMeal = TheMeal()
    var tempMealId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(NavigateToSaved))
        
        theMeal.getMealList() { meals in
            DispatchQueue.main.async {
                if let meals = meals {
                    self.mealList = meals
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath)
        let meal = mealList[indexPath.row]
        
        cell.textLabel?.text = meal.name
        cell.detailTextLabel?.text = "MealId: \(meal.mealId)"
        cell.imageView?.image = UIImage(named: meal.mealId)
        
        return cell
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String?, sender: Any?) -> Bool {
        if let ident = identifier {
            if ident == "showDetail" {
                guard let indexPath = self.tableView.indexPathForSelectedRow else {
                    // I use this segue programatically to travel to a saved meal.
                    // If the mealId is not null at this point we do want to continue
                    if (tempMealId != "") {
                        return true
                    }
                    
                    let alert = UIAlertController(
                        title: "ForMyMeal",
                        message: "kan uw voorkeursmaaltijd niet vinden.",
                        preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "ok", style: .default))
                    
                    return false
                }
                
                tempMealId = mealList[indexPath.row].mealId
            }
        }
        return true
    }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailController = segue.destination as? MealDetailController {
            if (tempMealId == "") {
                guard let indexPath = self.tableView.indexPathForSelectedRow else {
                    print("bruh, what did you do?")
                    return
                }
                
                if (self.tableView.indexPathForSelectedRow != nil) {
                    let clickedMeal = mealList[indexPath.row]
                    tempMealId = clickedMeal.mealId
                }
            }
                                    
            theMeal.getMealDetail(id: tempMealId) { mealDetail in
                DispatchQueue.main.async {
                    if let meal = mealDetail {
                        detailController.updateView(detail: meal)
                    }
                }
            }
        }
    }
    
    @objc func NavigateToSaved() {
        guard let mealId = UserDefaults.standard.string(forKey: "nl.avans.fml.savedmeal") else {
            print("dafuq?")
            
            let alert = UIAlertController(
                title: "ForMyMeal",
                message: "kan uw voorkeursmaaltijd niet vinden.",
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "ok", style: .default))
            
            self.present(alert, animated: true)
            
            return
        }
        
        tempMealId = mealId
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
}
