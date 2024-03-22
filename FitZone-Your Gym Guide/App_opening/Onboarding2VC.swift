//
//  Onboarding2VC.swift
//  FitZone-Your Gym Guide
//
//  Created by Trycatch Classes on 08/02/24.
//

import UIKit

class Onboarding2VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func NextBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Onboarding3VC") as! Onboarding3VC
        
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
}
