//
//  ExerciseSingleVC.swift
//  FitZone-Your Gym Guide
//
//  Created by Trycatch Classes on 13/02/24.
//

import UIKit
import youtube_ios_player_helper


struct SingleExerciceModel : Codable{
    
    var id : String?
    var name : String?
    var exercise_type : String?
    var exercise_equipments : String?
    var exercise_muscles : String?
    var description : String?
    var image : String?
    var timimg : String?
    var url : String?
    var steps : String?
}

class ExerciseSingleVC: UIViewController ,YTPlayerViewDelegate {
    
    var SingleExerciceArray = [SingleExerciceModel]()
    var SingleArray : ExerciceListModel?
    @IBOutlet weak var HeadNameLabel: UILabel!
    @IBOutlet weak var Imageview: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var CategoryNameLabel: UILabel!
    
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    
    @IBOutlet weak var StepsLabel: UILabel!
    
   

    @IBOutlet var PlayerView : YTPlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        PlayerView.delegate = self
        //PlayerView.load(withVideoId: "")
        guard let videoURL = SingleArray?.url else {
                // Handle the case when the URL is not available
                return
            }
        self.PlayerView.load(withVideoId: videoURL, playerVars: ["playsinline" : 1])
        self.NameLabel.text = SingleArray?.name
        GetSingleExercicelistAPI(catID: SingleArray?.id ?? "")
        self.HeadNameLabel.text = SingleArray?.name
        self.TimeLabel.text = SingleArray?.timimg
        self.CategoryNameLabel.text = SingleArray?.cat_difficulty
        self.DescriptionLabel.text = SingleArray?.description
        self.StepsLabel.text = SingleArray?.steps
        let url = URL(string: SingleArray?.image ?? "")
        self.Imageview.sd_setImage(with: url)
        self.PlayerView.layer.cornerRadius = 20
    }
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }

    @IBAction func BackBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    

}


extension ExerciseSingleVC{
    func GetSingleExercicelistAPI (catID : String){
        guard let url = URL(string: "https://appy.trycatchtech.com/v3/fit_zone/single_exercise?id=\(catID)") else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request){ data , error, response in
            if let error = error {
                print(error)
            }
            if let data = data {
                do{
                    let json = try JSONDecoder().decode([SingleExerciceModel].self, from: data)
//                    print("json Data\(json)")
                    self.SingleExerciceArray = json
                    
                    DispatchQueue.main.async {
                        
                    }
                }
                catch{
                    print("Error")
                }
            }
        }.resume()
    }
}
