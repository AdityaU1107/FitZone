//
//  DrinkWaterVC.swift
//  FitZone-Your Gym Guide
//
//  Created by Trycatch Classes on 09/02/24.
//

import UIKit

class DrinkWaterVC: UIViewController {
    var count: Int = 0
    @IBOutlet weak var GlassCount: UILabel!
    @IBOutlet weak var holderview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.holderview.layer.cornerRadius = 30
        self.holderview.layer.borderWidth = 1.0
        self.holderview.layer.borderColor = UIColor.white.cgColor
      
    }
    
    @IBAction func CancelBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func MinusBTn(_ sender: Any) {
        if count > 0 {
                    count -= 1
                    updateCountLabel()
                }
    }
    
    @IBAction func PlusBtn(_ sender: UIButton) {
        count += 1
                updateCountLabel()
    }
    
    @IBAction func AddBtn(_ sender: UIButton) {
        if let homeVC = presentingViewController as? HomeVC {
                    homeVC.updateCount(count)
                }
                dismiss(animated: true)
    }
    func updateCountLabel() {
            GlassCount.text = "\(count)"
        }
}
