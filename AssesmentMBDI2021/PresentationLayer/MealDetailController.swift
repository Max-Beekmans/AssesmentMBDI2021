//
//  MealDetailController.swift
//  AssesmentMBDI2021
//
//  Created by Max Beekmans on 3/2/21.
//

import UIKit

class MealDetailController : UIViewController {
    
    @IBOutlet weak var MealImage: UIImageView!
    @IBOutlet weak var MealName: UILabel!
    @IBOutlet weak var Area: UILabel!
    @IBOutlet weak var Category: UILabel!
    @IBOutlet weak var MealInstruction: UILabel!
    
    var detail : MealDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateView(detail: MealDetail) {
        MealImage.image = UIImage(named: detail.mealId)
        MealName.text = detail.name
        Area.text = detail.area
        Category.text = detail.category
        MealInstruction.text = detail.instructions
        self.detail = detail
    }
    
    @IBAction func SaveMeal(_ sender: Any) {
        guard let meal = detail else {
            print("what? how did you get to this view?")
            return
        }
        
        UserDefaults().set(meal.mealId, forKey: "nl.avans.fml.savedmeal")
        
        let alert = UIAlertController(
            title: "ForMyMeal",
            message: "Uw voorkeursmaaltijd is opgelsagen!",
            preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "mooizo", style: .default))
        
        self.present(alert, animated: true)
    }
}
