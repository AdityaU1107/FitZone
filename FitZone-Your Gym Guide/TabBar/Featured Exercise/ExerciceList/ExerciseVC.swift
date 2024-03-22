//
//  ExerciseVC.swift
//  FitZone-Your Gym Guide
//
//  Created by Trycatch Classes on 10/02/24.
//

import UIKit
import SDWebImage
struct ExerciceListModel:Codable{
    
    var id : String?
    var cat_difficulty : String?
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



class ExerciseVC: UIViewController {
    var FilteredexerciseArray = [ExerciceListModel]()
    var ExerciceListArray = [ExerciceListModel]()
    var isFiltering = false
    @IBOutlet weak var SearchBar: UISearchBar!
    
    @IBOutlet weak var Activityindicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var CollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView.register(UINib(nibName: "ExerciceListCVC", bundle: .main), forCellWithReuseIdentifier: "ExerciceListCVC")
        SearchBar.delegate = self
        GetExercicelistAPI()
    }
    

    @IBAction func FilterBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ExerciseFilterVC") as! ExerciseFilterVC
        vc.modalPresentationStyle = .popover
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
    }
    
    
    @IBAction func ExerciseBtn(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "ExerciseVC", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "ExerciseVC") as! ExerciseVC
//        vc.modalPresentationStyle = .fullScreen
//        vc.modalTransitionStyle = .crossDissolve
//        present(vc, animated: true)
    }
    
    @IBAction func HomeBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeVC", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    @IBAction func FoodBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "FoodVC", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FoodVC") as! FoodVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    
    
    
    @IBAction func MenuBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
}

extension ExerciseVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltering ? FilteredexerciseArray.count : ExerciceListArray.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExerciceListCVC", for: indexPath) as! ExerciceListCVC
        let exerciseitem: ExerciceListModel
        if isFiltering {
            exerciseitem = FilteredexerciseArray[indexPath.row]
        }else {
            exerciseitem = ExerciceListArray[indexPath.row]
        }
        cell.CatLabel.text = exerciseitem.cat_difficulty
        cell.ExerciseTypeLabel.text = exerciseitem.name
        let url = URL(string: exerciseitem.image ?? "")
        cell.ImageView.sd_setImage(with: url)
        cell.layer.cornerRadius = 20
        return cell
    }
}
extension ExerciseVC:UICollectionViewDelegateFlowLayout{
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
        let storyboard = UIStoryboard(name: "ExerciceSingleVC", bundle: .main)
            let vc = storyboard.instantiateViewController(withIdentifier: "ExerciseSingleVC") as! ExerciseSingleVC
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .coverVertical

            let exerciseItem: ExerciceListModel
       if isFiltering {
        guard indexPath.row < FilteredexerciseArray.count else {
            print("Index out of range: \(indexPath.row)")
            return
        }
        exerciseItem = FilteredexerciseArray[indexPath.row]
    } else {
        guard indexPath.row < ExerciceListArray.count else {
            print("Index out of range: \(indexPath.row)")
            return
        }
        exerciseItem = ExerciceListArray[indexPath.row]
    }

    vc.SingleArray = exerciseItem
        present(vc, animated: true)
        
    }
}

extension ExerciseVC{
    
    func GetExercicelistAPI (){
        showActivityIndicator()

        guard let url = URL(string: "https://appy.trycatchtech.com/v3/fit_zone/exercise_list?category_id=1,2,3") else { hideActivityIndicator()
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
//                    print("json Data\(json)")
                    self.ExerciceListArray = json
                    
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

extension ExerciseVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isFiltering = !searchText.isEmpty
        if isFiltering {
            filterContentForSearchText(searchText)
        }else{
            CollectionView.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        isFiltering = false
        CollectionView.reloadData()
        GetExercicelistAPI()
    }
    func filterContentForSearchText(_ searchText: String) {
        FilteredexerciseArray = ExerciceListArray.filter { (exercise) -> Bool in
            return exercise.name?.lowercased().contains(searchText.lowercased()) ?? false
        }
        CollectionView.reloadData()
    }
}

extension ExerciseVC {
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
