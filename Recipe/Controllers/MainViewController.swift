//
//  ViewController.swift
//
//  Created by alsh on 10.10.17.
//  Copyright © 2017 wsoft. All rights reserved.
//

import UIKit
import Firebase




class MainViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data = [NSDictionary]()
    var ref:DatabaseReference!
    
    //is the device landscape or portrait
    var isPortraid = true
    
  
    func fetchDataFromFirebase(){
        EZLoadingActivity.show("loading...", disableUI: true)
        ref = Database.database().reference()
        ref.observe(.value, with: { (snapshot) in
            let dataDict = snapshot.value as! NSDictionary
          //  dataDict = dataDict.filter { $0 is NSDictionary }
            
        
            self.data = dataDict["data"] as! [NSDictionary]
            
            //print (self.data)
            self.tableView.reloadData()
            EZLoadingActivity.hide()
        })
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        fetchDataFromFirebase()
        
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.orientationChanged), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        

        
    }

    
    
    
    
    @objc func orientationChanged(){
        if UIDevice.current.orientation.isLandscape {
            isPortraid = false
        } else {
            isPortraid = true
        }
        
        tableView.reloadData()
    }
    
    
    
    
    //TableView Data Source and Delegate
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for:indexPath) as! MainScreenTableViewCell
        let rowData = self.data[indexPath.row]
        
        let imageName  = rowData["imageName"] as! String
        cell.backgroundImageView.image = UIImage(named: imageName)
        let label = rowData["categoryName"] as! String
        cell.mealCategoryLabel.text = label
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let categoryViewController = storyboard.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        //let rowData = self.data[indexPath.row]
        //categoryViewController.categoryTitle = rowData["categoryName"] as! String
        //var categoryData = rowData["category"] as! [NSDictionary]
        
        categoryViewController.indexData = indexPath.row
       // print(indexPath.row)
        self.navigationController?.pushViewController(categoryViewController, animated: true)
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isPortraid {
        return UIScreen.main.bounds.height/5.3
        } else {
            return UIScreen.main.bounds.height/1.2
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
 
    
}


