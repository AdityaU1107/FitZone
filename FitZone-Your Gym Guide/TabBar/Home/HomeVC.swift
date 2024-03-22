//
//  HomeVC.swift
//  FitZone-Your Gym Guide
//
//  Created by Trycatch Classes on 08/02/24.
//

import UIKit

struct exercisecatModel : Codable{
    var id : String?
    var cat_difficulty : String?
    //var image : String
}

struct UserData : Codable {
    var count: Int = 0
    var oneRepMax: Double = 0.0
    var bmi: Double = 0.0
}

struct QuickExerciseData:Codable{
    var image: String
    var CatName:String
    var detail:String
}

class HomeVC: UIViewController {
    var exercisecat = [exercisecatModel]()
    var userData = UserData() {
            didSet {
                saveUserData()
            }
        }
    var imagearray = ["image 3","image 4","image 11"]
    @IBOutlet weak var MyPageControl: UIPageControl!
    @IBOutlet weak var CountLabel: UILabel!
    @IBOutlet weak var RMLabel: UILabel!
    
    @IBOutlet weak var BMIlabel: UILabel!
    var currentcellindex = 0
    var timer:Timer?
    let ExerciseArray : [QuickExerciseData] =
    [
        QuickExerciseData(image:"Squats", CatName: "Squats", detail: "Squats are effective for \nbuilding  lower body strength and \nenhancing overall lower body"),
        QuickExerciseData(image:"Bicep Curls", CatName: "Bicep Curls", detail: "Biceps curls are a powerful\nexercise to sculpt strong, \nwell-defined arm muscles."),
        QuickExerciseData(image:"Dead Lift", CatName: "Dead Lift", detail: "Deadlifts are a powerhouse \nexercise that primarily targets \nyour back,legs & grip strength.")
    ]
    
    @IBOutlet weak var CollectionView: UICollectionView!
    
    @IBOutlet weak var CollectionView2: UICollectionView!
    
    @IBOutlet weak var holderview1: UIView!
    @IBOutlet weak var holderview2: UIView!
    
    @IBOutlet weak var holderview3: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        CollectionView.register(UINib(nibName: "CollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CollectionViewCell")
        CollectionView2.register(UINib(nibName: "CollectionViewCell2", bundle: .main), forCellWithReuseIdentifier: "CollectionViewCell2")
        self.holderview1.layer.cornerRadius = 30
        self.holderview1.layer.borderWidth = 1.0
        self.holderview1.layer.borderColor = UIColor.purple.cgColor
        self.holderview2.layer.cornerRadius = 30
        self.holderview2.layer.borderWidth = 1.0
        self.holderview2.layer.borderColor = UIColor.systemGreen.cgColor
        self.holderview3.layer.cornerRadius = 30
        self.holderview3.layer.borderWidth = 1.0
        self.holderview3.layer.borderColor = UIColor.orange.cgColor
       //Saving user data of bmi water and one rep max
        if let savedData = loadUserData() {
                    userData = savedData
                    reloadData()
                }
        exerciseCatlistAPI()
        // for scrolling page controls
        timer = Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(slideToNext), userInfo: nil, repeats: true)
        MyPageControl.numberOfPages = ExerciseArray.count
    }
    
    
    @IBAction func MenuBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    
    
    @IBAction func ExerciseListBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "ExerciseVC", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ExerciseVC") as! ExerciseVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    @IBAction func FoodlistBtn(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "FoodVC", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FoodVC") as! FoodVC
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    
    
    
    //for scrolling collection view
    @objc func slideToNext(){
        if currentcellindex < ExerciseArray.count-1{
            currentcellindex = currentcellindex + 1
        }
        else{
            currentcellindex = 0
        }
        MyPageControl.currentPage = currentcellindex
        CollectionView.scrollToItem(at: IndexPath(item: currentcellindex, section: 0), at: .right, animated: true)
    }
    
    func saveUserData() {
            let encoder = JSONEncoder()
            if let encodedData = try? encoder.encode(userData) {
                UserDefaults.standard.set(encodedData, forKey: "userData")
            }
        }
    func loadUserData() -> UserData? {
            if let savedData = UserDefaults.standard.data(forKey: "userData"),
               let loadedData = try? JSONDecoder().decode(UserData.self, from: savedData) {
                return loadedData
            }
            return nil
        }
    
    @IBAction func TapBtn(_ sender: UIButton) {
              
        presentBMIVC()
        
    }
    
    @IBAction func Weight(_ sender: UIButton) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "WeightVC") as! WeightVC
//        vc.modalPresentationStyle = .popover
//        vc.modalTransitionStyle = .coverVertical
//        present(vc, animated: true)
        presentWeightVC()
    }
    
    @IBAction func DrinkBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DrinkWaterVC") as! DrinkWaterVC
        vc.modalPresentationStyle = .popover
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
    }
    
    func presentBMIVC() {
            let storyboard = UIStoryboard(name: "HomeVC", bundle: nil)
            if let bmivc = storyboard.instantiateViewController(withIdentifier: "BMIVC") as? BMIVC {
                bmivc.onBMICalculated = { [weak self] bmi in
                    // Handle the calculated BMI here
                    self?.handleBMICalculated(bmi)
                }
                present(bmivc, animated: true, completion: nil)
            }
        }
    func handleBMICalculated(_ bmi: Double) {
            // Handle the calculated BMI, for example, store it in a variable or update UI
            print("BMI Calculated: \(bmi)")
        self.BMIlabel.text = "\(String(format: "%.2f", bmi))"
        userData.bmi = bmi
            // Dismiss BMIVC if needed
            dismiss(animated: true, completion: nil)
        }
    
    func presentWeightVC() {
            let storyboard = UIStoryboard(name: "HomeVC", bundle: nil)
            if let weightVC = storyboard.instantiateViewController(withIdentifier: "WeightVC") as? WeightVC {
                weightVC.on1RMCalculated = { [weak self] oneRepMax in
                    // Handle the calculated 1RM here
                    self?.handle1RMCalculated(oneRepMax)
                }
                present(weightVC, animated: true, completion: nil)
            }
        }

        func handle1RMCalculated(_ oneRepMax: Double) {
            // Handle the calculated 1RM, for example, update a label
            RMLabel.text = "\(String(format: "%.2f", oneRepMax))"
            userData.oneRepMax = oneRepMax
        }
    func updateCount(_ count: Int) {
        CountLabel.text = "\(count)"
        userData.count = count
        }
    func reloadData() {
        // Perform data reloading logic here

        // Update labels with stored data
        CountLabel.text = "\(userData.count)"
        RMLabel.text = "\(String(format: "%.2f", userData.oneRepMax))"
        BMIlabel.text = "\(String(format: "%.2f", userData.bmi))"
    }
    
}

extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.CollectionView{
            return ExerciseArray.count
        }else if collectionView == self.CollectionView2 {
            return exercisecat.count
        } else {
            // Return a default value or handle the case where neither condition is met
            return 0
        }
        
        
        //return 30
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      //  var cell : UICollectionViewCell
        
        if collectionView == self.CollectionView{
            let  cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
            cell.CategoryLbl.text = ExerciseArray[indexPath.row].CatName
            cell.ImageView.image = UIImage(named: ExerciseArray[indexPath.row].image)
            cell.DetailLabel.text = ExerciseArray[indexPath.row].detail
            cell.layer.cornerRadius = 10
            cell.layer.borderWidth = 1.0
            cell.layer.borderColor = UIColor.lightGray.cgColor
            return cell
        }else if collectionView == self.CollectionView2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell2", for: indexPath) as! CollectionViewCell2
            cell.CategoryName.text = exercisecat[indexPath.row].cat_difficulty
            cell.ImageView.image = UIImage(named: imagearray[indexPath.row])
            return cell
        }
        else{
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.CollectionView{
        
        }else if collectionView == self.CollectionView2 {
            let storyboard = UIStoryboard(name: "PrivacyVC", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "CategoryVC") as! CategoryVC
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            vc.Catidarray = exercisecat[indexPath.row]
            present(vc, animated: true)
        }
    }
}

extension HomeVC:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.CollectionView{
            let width = ((collectionView.frame.width)-20)
            let height = collectionView.frame.height
            return CGSize(width: width, height: height)
        }else if collectionView == self.CollectionView2 {
            
            let width = ((collectionView.frame.width)-20)
            let height = (collectionView.frame.height)/2
            return CGSize(width: width, height: height)
        } else {
            // Return a default value or handle the case where neither condition is met
            return CGSize(width: 0, height: 0)
        }
    }
}

extension HomeVC{
    func exerciseCatlistAPI (){
        guard let url = URL(string: "https://appy.trycatchtech.com/v3/fit_zone/category_list") else {return}
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request){ data , error, response in
            if let error = error {
                print(error)
            }
            if let data = data {
                do{
                    let json = try JSONDecoder().decode([exercisecatModel].self, from: data)
//                    print("json Data\(json)")
                    self.exercisecat = json
                    
                    DispatchQueue.main.async {
                        self.CollectionView2.reloadData()
                    }
                }
                catch{
                    print("Error")
                }
            }
        }.resume()
    }
}
