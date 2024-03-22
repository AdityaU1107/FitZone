//
//  BMIVC.swift
//  FitZone-Your Gym Guide
//
//  Created by Trycatch Classes on 09/02/24.
//

import UIKit

class BMIVC: UIViewController {
    var onBMICalculated: ((Double) -> Void)?
    
    @IBOutlet weak var HeightTextfield: UITextField!
    
    @IBOutlet weak var WeightTextfield: UITextField!
    
    @IBOutlet weak var holderview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.holderview.layer.cornerRadius = 30
        self.holderview.layer.borderWidth = 1.0
        self.holderview.layer.borderColor = UIColor.white.cgColor
        
    }
    
    @IBAction func CancelButton(_ sender: UIButton) {
        dismiss(animated: true)
        
        
    }
    
    @IBAction func CalculateButton(_ sender: UIButton) {
        guard let heightString = HeightTextfield.text, let height = Double(heightString),
                  let weightString = WeightTextfield.text, let weight = Double(weightString) else {
                showAlert(message: "Please enter valid height and weight.")
                return
            }
        let heightInMeters = height/100
           let bmi = weight / (heightInMeters * heightInMeters)
        
        onBMICalculated?(bmi)
        
        
        
        //showAlert(message: "Your BMI is \(String(format: "%.2f", bmi))")
    }
    private func showAlert(message: String) {
           let alert = UIAlertController(title: "BMI Calculator", message: message, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
           alert.addAction(okAction)
           present(alert, animated: true, completion: nil)
       }
    
}
