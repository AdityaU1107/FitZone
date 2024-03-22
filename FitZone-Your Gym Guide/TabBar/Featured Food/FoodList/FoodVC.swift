//
//  FoodVC.swift
//  FitZone-Your Gym Guide
//
//  Created by Trycatch Classes on 10/02/24.
//

import UIKit
import SDWebImage


struct FoodListModel:Codable{
    var id:String?
    var name:String?
    var description:String?
    var image:String?
    var calories:String?
    var sodium:String?
    var fats:String?
    var carbs:String?
    var protein:String?
}


class FoodVC: UIViewController {
    
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var SearchBar: UISearchBar!
    
    var FoodlistArray = [FoodListModel]()
    var filteredFoodArray = [FoodListModel]()
    var isFiltering = false
    
    let colors: [UIColor] = [.yellow,.purple,.systemPink,.orange]
    
    @IBOutlet weak var collectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionview.register(UINib(nibName: "FoodCVC", bundle: .main), forCellWithReuseIdentifier: "FoodCVC")
        SearchBar.delegate = self
GetFoodlistAPI()
        
    }
    
    
    @IBAction func ExerciceBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ExerciseVC", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ExerciseVC") as! ExerciseVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    @IBAction func HomeBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeVC", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
        
    }
    
    @IBAction func ItemBtn(_ sender: UIButton) {
//        let storyboard = UIStoryboard(name: "FoodVC", bundle: nil)
//        let vc = storyboard.instantiateViewController(withIdentifier: "FoodVC") as! FoodVC
//        vc.modalPresentationStyle = .fullScreen
//        vc.modalTransitionStyle = .crossDissolve
//        present(vc, animated: true)

    }
    
    
    @IBAction func filterBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
        vc.modalPresentationStyle = .popover
        vc.modalTransitionStyle = .coverVertical
        vc.callback = { data in
            self.filterData(data: data)
        }
        present(vc, animated: true)
    }
    
    @IBAction func MenuBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    func filterData(data: FilterData) {
        
        filteredFoodArray = FoodlistArray.filter { Int($0.fats ?? "") ?? 0 > data.minFat && Int($0.fats ?? "") ?? 0 < data.maxFat  }
        
        
        
        
    }
    
    
}

extension FoodVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isFiltering ? filteredFoodArray.count : FoodlistArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FoodCVC", for: indexPath) as! FoodCVC
        
        let foodItem: FoodListModel
        if isFiltering {
            foodItem = filteredFoodArray[indexPath.row]
        } else {
            foodItem = FoodlistArray[indexPath.row]
        }
        
        cell.NameLabel.text = foodItem.name
        let url = URL(string: foodItem.image ?? "")
        cell.imageview.sd_setImage(with: url)
        cell.CaloriesLabel.text = "Calories:\(foodItem.calories ?? "")Kcal \n100gm"
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1.0
        cell.HolderView.backgroundColor = colors[indexPath.row % colors.count]
        cell.layer.borderColor = UIColor.gray.cgColor
        
        return cell
    }

    
}
extension FoodVC:UICollectionViewDelegateFlowLayout{
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
        
        
        let numberOfItemsPerRow: CGFloat = 2
        let spacing: CGFloat = 10
        let availableWidth = collectionView.frame.width - spacing * (numberOfItemsPerRow + 1)
        let itemWidth = availableWidth / numberOfItemsPerRow
        let itemHeight = itemWidth
        
        return CGSize(width: itemWidth, height: itemHeight)
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "SingleFoodVC", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "SingleFoodVC") as! SingleFoodVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        
        let foodItem: FoodListModel
        if isFiltering{
            guard indexPath.row < filteredFoodArray.count else {
                print("index out of range:\(indexPath.row)")
                return
            }
            foodItem = filteredFoodArray[indexPath.row]
        }else {
            guard indexPath.row < FoodlistArray.count else{
                print("index oput of range:\(indexPath.row)")
                return
            }
            foodItem = FoodlistArray[indexPath.row]
        }
        vc.Foodarray = foodItem
        present(vc, animated: true)
        
    }
}
    
    extension FoodVC: UISearchBarDelegate {
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            isFiltering = !searchText.isEmpty
            if isFiltering {
                filterContentForSearchText(searchText)
            } else {
                
                collectionview.reloadData()
            }
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = nil
            searchBar.resignFirstResponder()
            isFiltering = false
            collectionview.reloadData()
            GetFoodlistAPI()
        }
        
        func filterContentForSearchText(_ searchText: String) {
            filteredFoodArray = FoodlistArray.filter { (food) -> Bool in
                return food.name?.lowercased().contains(searchText.lowercased()) ?? false
            }
            collectionview.reloadData()
        }
    }

extension FoodVC{
    
    func showActivityIndicator() {
        DispatchQueue.main.async {
            self.ActivityIndicator.startAnimating()
            self.ActivityIndicator.isHidden = false
        }
    }

    func hideActivityIndicator() {
        DispatchQueue.main.async {
            self.ActivityIndicator.stopAnimating()
            self.ActivityIndicator.isHidden = true
        }
    }

    func GetFoodlistAPI (){
        showActivityIndicator()
        guard let url = URL(string: "https://appy.trycatchtech.com/v3/fit_zone/food_list") else { hideActivityIndicator()
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
                    let json = try JSONDecoder().decode([FoodListModel].self, from: data)
//                    print("json Data\(json)")
                    self.FoodlistArray = json
                    
                    DispatchQueue.main.async {
                        self.collectionview.reloadData()
                    }
                }
                catch{
                    print("Error")
                }
            }
        }.resume()
    }
    
    
    
    
    
    
}
