//
//  PrivacyVC.swift
//  FitZone-Your Gym Guide
//
//  Created by Trycatch Classes on 15/02/24.
//

import UIKit

class PrivacyVC: UIViewController {

    @IBOutlet weak var HeadLabel: UILabel!
    
    @IBOutlet weak var TextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func BackBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
   
}
