//
//  ExerciseFilterVC.swift
//  FitZone-Your Gym Guide
//
//  Created by Trycatch Classes on 15/02/24.
//

import UIKit

class ExerciseFilterVC: UIViewController {

    
    @IBOutlet weak var Holderview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.Holderview.layer.cornerRadius = 30
    }
    
    @IBAction func CancelBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
   

}
