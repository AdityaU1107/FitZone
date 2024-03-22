//
//  MenuVC.swift
//  FitZone-Your Gym Guide
//
//  Created by Trycatch Classes on 14/02/24.
//

import UIKit
import StoreKit
class MenuVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    @IBAction func CancelBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
    @IBAction func DismissBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func ExerciseBtn(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "ExerciseVC", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ExerciseVC") as! ExerciseVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    @IBAction func DietBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "FoodVC", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FoodVC") as! FoodVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    @IBAction func ShareBtn(_ sender: UIButton) {
        let shareText = "Check out this amazing fitness app!"
                let shareAppURL = URL(string: "https://www.FitZone.com")!

                let activityViewController = UIActivityViewController(activityItems: [shareText, shareAppURL], applicationActivities: nil)
                activityViewController.popoverPresentationController?.sourceView = self.view

                present(activityViewController, animated: true, completion: nil)
    }
    
    @IBAction func RateusBtn(_ sender: UIButton) {
        if #available(iOS 14.0, *) {
                   // On iOS 14 and later, use SKStoreReviewController
                   SKStoreReviewController.requestReview()
               } else {
                   // On earlier versions, open the App Store URL
                   openAppStoreForRating()
               }
    }
    func openAppStoreForRating() {
           // Replace "your-app-id" with your actual App Store ID
           let appStoreURL = URL(string: "https://apps.apple.com/us/app/your-app-id")!

           if UIApplication.shared.canOpenURL(appStoreURL) {
               UIApplication.shared.open(appStoreURL, options: [:], completionHandler: nil)
           }
       }

          
    @IBAction func PrivacyPolicyBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "PrivacyVC", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "PrivacyVC") as! PrivacyVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    @IBAction func LanguageBtn(_ sender: UIButton) {
    }
}
