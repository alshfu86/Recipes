//
//  CategoryViewController.swift
//
//  Created by polat on 1/3/17.
//  Copyright © 2017 wsoft. All rights reserved.
//

import UIKit
import Kingfisher
import FirebaseDatabase

class CategoryViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var data = [NSDictionary]()
    var recipes = [Recipe]()
    var indexData : Int = 0
    var categoryTitle = ""
    var ref:DatabaseReference!
    
    let youtubeBaseImageURL = "http://img.youtube.com/vi/"
    
    @IBOutlet weak var tableView: UITableView!
    
    //is the device landscape or portrait
    var isPortraid = true
    
    func loadRecipe(){
        Database.database().reference().child("data").child(String(indexData)).child("category").observe(.childAdded){(snapshot:DataSnapshot) in
            if let dict = snapshot.value as?[String:Any]{
                let title = dict["title"] as! String
                let imageQuality = dict["imageQuality"] as! String
                let recipeIndex = snapshot.key
                let youtubeID = dict["youtubeID"] as! String
                let ingredients = dict["ingredients"] as! String
                let categoryIndex = String (self.indexData)
                let recipe = Recipe(titleText: title, imageQualityString: imageQuality,  recipeIndexString: recipeIndex, youtubeIDString: youtubeID, ingredientsString: ingredients, categoryIndexString: categoryIndex )
                ///let recipe = Recipe(titleText: title, imageQualityString: imageQuality,  youtubeIDString: youtubeID, ingredientsString: ingredients)
                self.recipes.append(recipe)
                self.tableView.reloadData()
                
            }
            print(snapshot.key)
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        loadRecipe()
       // var recipe = Recipe(titleText: "test", imageString: "test", recipeIndexString: "test")
        
    
        
        let backButton = UIBarButtonItem(image: UIImage(named:"chevron"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(back))
        
        self.navigationItem.leftBarButtonItem = backButton
        self.tableView.delegate = self
        self.title = categoryTitle
        
      print(self.indexData)
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.orientationChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        
        if UIDevice.current.orientation.isLandscape {
            isPortraid = false
     }
      //  self.data = ( removeNSNull(from: self.data ) as NSDictionary )
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return recipes.count
    }
    
    
    
    
    func orientationChanged(){
        if UIDevice.current.orientation.isLandscape {
            isPortraid = false
        } else {
            isPortraid = true
        }
        
        tableView.reloadData()
    }
    
    

    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
  
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for:indexPath) as! CategoryTableViewCell
        let imageUrl = recipes[indexPath.row].youtubeID
        let imageQuality = recipes[indexPath.row].imageQuality
        let urlPath = youtubeBaseImageURL + imageUrl + "/" + imageQuality + ".jpg"
        let url = URL(string: urlPath)
        cell.recipeImageView.kf.setImage(with: url)
        cell.recipeLabel?.text = recipes[indexPath.row].title
//        print("uString(describing: rl )path = \(String(describing: url))")
        return cell
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let playerViewController = storyboard.instantiateViewController(withIdentifier: "PlayerViewController") as! PlayerViewController
        let rowData = recipes[indexPath.row]
        let youtubeUrl = rowData.youtubeID
        let ingredients = rowData.ingredients
        let categoryIndex = rowData.categoryIndex
        let recipeIndex = rowData.recipeIndex
        

        
        playerViewController.urlPath = youtubeUrl
        playerViewController.about = ingredients
        playerViewController.categoryIndex = categoryIndex
        playerViewController.recipeIndex = recipeIndex
        
        //        print(youtubeUrl)
        //        print(ingredients)
        //        print(rowData.title)
        //        print(rowData.youtubeID)
        //        print(rowData.ingredients)
        //        print(rowData.imageQuality)
        
        
        self.navigationController?.pushViewController(playerViewController, animated: true)
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        if isPortraid {return UIScreen.main.bounds.height/5
        } else {
            return UIScreen.main.bounds.height/5.2
        }

        
        
    }
    
    func removeNSNull(from dict: [AnyHashable: Any]) -> [AnyHashable:Any] {
        var mutableDict = dict
        let keysWithEmptString = dict.filter { $0.1 is NSNull }.map { $0.0 }
        for key in keysWithEmptString {
            mutableDict[key] = ""
        }
        return mutableDict
    }
    
    
    @IBAction func unwindToCategory(sender: UIStoryboardSegue){
    }
}
