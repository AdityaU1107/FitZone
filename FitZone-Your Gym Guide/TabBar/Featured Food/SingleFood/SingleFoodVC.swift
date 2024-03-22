//
//  SingleFoodVC.swift
//  FitZone-Your Gym Guide
//
//  Created by Trycatch Classes on 12/02/24.
//

import UIKit

class SingleFoodVC: UIViewController {
    var Foodarray : FoodListModel?
    @IBOutlet weak var ItemLabel: UILabel!
    
    @IBOutlet weak var Imageview: UIImageView!
    
    @IBOutlet weak var CatNameLabel: UILabel!
    
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    @IBOutlet weak var CalorieLabel: UILabel!
    
    @IBOutlet weak var SodiumLabel: UILabel!
    
    @IBOutlet weak var FatLabel: UILabel!
    
    @IBOutlet weak var FatProgressview: UIProgressView!
    
    @IBOutlet weak var CarbsLabel: UILabel!
    @IBOutlet weak var CarbsProgressView: UIProgressView!
    
    
    @IBOutlet weak var ProteinLabel: UILabel!
    @IBOutlet weak var ProteinProgressView: UIProgressView!
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ItemLabel.text = Foodarray?.name
        self.CatNameLabel.text = Foodarray?.name
        self.DescriptionLabel.text = Foodarray?.description
        self.CalorieLabel.text = Foodarray?.calories
        self.SodiumLabel.text = Foodarray?.sodium
        self.FatLabel.text = "Fat\n \(Foodarray?.fats ?? "")"
        self.CarbsLabel.text = "Carbs\n \(Foodarray?.carbs ?? "")"
        self.ProteinLabel.text = "Protein\n \(Foodarray?.protein ?? "")"
        let url = URL(string: Foodarray?.image ?? "")
        self.Imageview.sd_setImage(with: url)
        
        if let fatsString = Foodarray?.fats, let fats = Double(fatsString) {
                    updateFatProgressView(fats: fats)
                }
        if let CarbsString = Foodarray?.carbs, let carbs = Double(CarbsString) {
                    updateCarbsProgressView(carbs: carbs)
                }
        if let ProteinString = Foodarray?.protein, let protein = Double(ProteinString) {
                    updateProteinProgressView(protein: protein)
                }
        
        
        
    }
    func updateFatProgressView(fats: Double) {
           // Assuming maxFat is the maximum amount of fats a food item can have
           let maxFat: Double = 100.0

           // Calculate the progress value
           let progressValue = Float(fats / maxFat)

           // Update the progress bar
           FatProgressview.progress = progressValue
       }
    func updateCarbsProgressView(carbs: Double) {
           // Assuming maxFat is the maximum amount of fats a food item can have
           let maxFat: Double = 100.0

           // Calculate the progress value
           let progressValue = Float(carbs / maxFat)

           // Update the progress bar
           FatProgressview.progress = progressValue
       }
    func updateProteinProgressView(protein: Double) {
           // Assuming maxFat is the maximum amount of fats a food item can have
           let maxFat: Double = 100.0

           // Calculate the progress value
           let progressValue = Float(protein / maxFat)

           // Update the progress bar
           FatProgressview.progress = progressValue
       }
    
    @IBAction func BackBtn(_ sender: UIButton) {
     dismiss(animated: true)
        
    }
    
    

}
