//
//  exerciseCatVC.swift
//  FitZone-Your Gym Guide
//
//  Created by Trycatch Classes on 17/02/24.
//

import UIKit
import youtube_ios_player_helper
class exerciseCatVC: UIViewController,YTPlayerViewDelegate {

    var Array:ExerciceListModel?
    
    
    @IBOutlet weak var HeadLabel: UILabel!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var NameLabel: UILabel!
    
    //@IBOutlet weak var HolderView: UIView!
    @IBOutlet weak var TimeLabel: UILabel!
    @IBOutlet weak var CatLabel: UILabel!
    @IBOutlet var PlayerView : YTPlayerView!
    @IBOutlet weak var StepsLabel: UILabel!
    @IBOutlet weak var DescriptionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        PlayerView.delegate = self
        guard let videoURL = Array?.url else {
                // Handle the case when the URL is not available
                return
            }
        self.PlayerView.load(withVideoId: videoURL, playerVars: ["playsinline" : 1])
        self.NameLabel.text = Array?.name
//        GetSingleExercicelistAPI(catID: SingleArray?.id ?? "")
        self.HeadLabel.text = Array?.name
        self.TimeLabel.text = Array?.timimg
        self.CatLabel.text = Array?.cat_difficulty
        self.DescriptionLabel.text = Array?.description
        self.StepsLabel.text = Array?.steps
        let url = URL(string: Array?.image ?? "")
        self.ImageView.sd_setImage(with: url)
        //self.HolderView.layer.cornerRadius = 20
    }
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }

    @IBAction func BackBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
}
