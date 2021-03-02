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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(NavigateToSaved))
        
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
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailController = segue.destination as? MealDetailController {
            if (self.tableView.indexPathForSelectedRow != nil) {
                let clickedMeal = mealList[self.tableView.indexPathForSelectedRow!.row]
                tempMealId = clickedMeal.mealId
            }
            
            if (tempMealId == "") {
                return
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
        let mealId = UserDefaults.standard.string(forKey: "nl.avans.fml.savedmeal")
        
        if (mealId != nil) {
            tempMealId = mealId!
            performSegue(withIdentifier: "showDetail", sender: nil)
            return
        }
        
        let alert = UIAlertController(
            title: "ForMyMeal",
            message: "kan uw voorkeursmaaltijd niet vinden.",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        
        self.present(alert, animated: true)
    }
}
