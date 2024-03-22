//
//  FilterVC.swift
//  FitZone-Your Gym Guide
//
//  Created by Trycatch Classes on 15/02/24.
//

import UIKit

struct FilterData {
    let minFat: Int
    let maxFat: Int
}

class FilterVC: UIViewController {
    
    
    @IBOutlet weak var Holderview: UIView!
    @IBOutlet weak var temp: UISlider!
    
    var callback: ((FilterData) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.Holderview.layer.cornerRadius = 30
        
        let thumbImg = UIImageView(frame: CGRect(x: 0, y: 0, width: 10, height: 40))
        thumbImg.image = UIImage(named: "")
        self.temp.setThumbImage(thumbImg.image, for: .normal)
        self.temp.setThumbImage(thumbImg.image, for: .selected)
    }
    
    @IBAction func CancelBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    

}
