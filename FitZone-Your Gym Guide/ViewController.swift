//
//  ViewController.swift
//  FitZone-Your Gym Guide
//
//  Created by Trycatch Classes on 08/02/24.
//

import UIKit



class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func AcceptBtn(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "Onboarding1VC") as! Onboarding1VC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
       present(vc, animated: true)
        
    }
    
    @IBAction func PrivacyPolicyBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "PrivacyVC", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PrivacyVC") as! PrivacyVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
}
