//
//  Onboarding1VC.swift
//  FitZone-Your Gym Guide
//
//  Created by Trycatch Classes on 08/02/24.
//

import UIKit

class Onboarding1VC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func NextBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Onboarding2VC") as! Onboarding2VC
        
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
       present(vc, animated: true)
    }
    
    @IBAction func SkipBtn(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "HomeVC", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        present(vc, animated: true)
    }
    
}
