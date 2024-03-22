//
//  CategoryVC.swift
//  FitZone-Your Gym Guide
//
//  Created by Trycatch Classes on 16/02/24.
//

import UIKit

class CategoryVC: UIViewController {

    var Catidarray : exercisecatModel?
    var exercises = [ExerciceListModel]()
    @IBOutlet weak var Catlabel: UILabel!
    
   @IBOutlet weak var Activityindicator: UIActivityIndicatorView!
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView.register(UINib(nibName: "ExerciceListCVC", bundle: .main), forCellWithReuseIdentifier: "ExerciceListCVC")
        self.Catlabel.text = Catidarray?.cat_difficulty
        GetcatExercicelistAPI(catid: Catidarray?.id ?? "")
    }
    
    @IBAction func BackBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    func GetcatExercicelistAPI (catid:String){
        showActivityIndicator()

        guard let url = URL(string: "https://appy.trycatchtech.com/v3/fit_zone/exercise_list?category_id=\(catid)") else { hideActivityIndicator()
            return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request){ data , error, response in
            defer {
                            self.hideActivityIndicator()
                        }
            if let error = error {
                print(error)
            }
            if let data = data {
                do{
                    let json = try JSONDecoder().decode([ExerciceListModel].self, from: data)
                   print("json Data\(json)")
                    self.exercises = json
                    
                    DispatchQueue.main.async {
                        self.CollectionView.reloadData()
                    }
                }
                catch{
                    print("Error")
                }
            }
        }.resume()
    }
    
   

}
extension CategoryVC:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return exercises.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExerciceListCVC", for: indexPath) as! ExerciceListCVC
        cell.CatLabel.text = exercises[indexPath.row].cat_difficulty
        cell.ExerciseTypeLabel.text = exercises[indexPath.row].name
        let url = URL(string: exercises[indexPath.row].image ?? "")
        cell.ImageView.sd_setImage(with: url)
        cell.layer.cornerRadius = 20
        return cell
    }
}

extension CategoryVC {
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.Activityindicator.startAnimating()
            self.Activityindicator.isHidden = false
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.Activityindicator.stopAnimating()
            self.Activityindicator.isHidden = true
        }
    }
}

extension CategoryVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = ((collectionView.frame.width)-20)
            let height = (collectionView.frame.height)/4
            return CGSize(width: width, height: height)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "exerciseCatVC") as! exerciseCatVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        vc.Array = exercises[indexPath.row]
        
            present(vc, animated: true)
    }
}
