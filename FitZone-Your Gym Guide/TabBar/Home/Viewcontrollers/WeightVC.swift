//
//  WeightVC.swift
//  FitZone-Your Gym Guide
//
//  Created by Trycatch Classes on 09/02/24.
//

import UIKit

class WeightVC: UIViewController {

    var on1RMCalculated: ((Double) -> Void)?
    @IBOutlet weak var WeightTF: UITextField!
    @IBOutlet weak var holderview: UIView!
    @IBOutlet weak var RepsTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.holderview.layer.cornerRadius = 20
        self.holderview.layer.borderWidth = 1.0
        self.holderview.layer.borderColor = UIColor.white.cgColor
       
    }
    
    @IBAction func CancelBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func CalculateButton(_ sender: UIButton) {
        guard let weightString = WeightTF.text, let weight = Double(weightString),
                      let repsString = RepsTextfield.text, let reps = Double(repsString) else {
                    showAlert(message: "Please enter valid weight and reps.")
                    return
                }
        let oneRepMax = weight * (1 + 0.0333 * reps)
        on1RMCalculated?(oneRepMax)
        dismiss(animated: true)
        showAlert(message: "Estimated 1RM: \(String(format: "%.2f", oneRepMax))")
    }
    
    private func showAlert(message: String) {
            let alert = UIAlertController(title: "Epley Equation", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }
}
