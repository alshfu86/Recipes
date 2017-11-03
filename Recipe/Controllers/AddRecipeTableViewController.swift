//
//  AddRecipeTableViewController.swift
//  Recipe
//
//  Created by alsh on 27.10.17.
//  Copyright © 2017 wsoft. All rights reserved.
//

import UIKit
import Firebase
import JSSAlertView


class AddRecipeTableViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {


    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dataPicker: UIPickerView!
    @IBOutlet weak var ingridients: UITextView!
    @IBOutlet weak var youtubeID: UITextField!
    //
   
    
    //
    var pickerData = ["Fuckost", "SOPPA", "HUVUDRÄTT", "BRÖD OCH PASTA","SÖTASAKER", "DRYCK"]
    var category:String = "Pizzor"
    var indexOfRowInDataPicker : String = "0"
    var curentCountOfChildInCategory : Int = 0
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView( _ icker: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ picker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ picker: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        category = pickerData[row]
        indexOfRowInDataPicker = String(row)
        print(indexOfRowInDataPicker)
    }
    

    override func viewDidLoad() {
        
        
        print(curentCountOfChildInCategory)
        
        dataPicker.layer.cornerRadius=8.0
        dataPicker.layer.borderWidth=1.0
        
        nameTextField.layer.cornerRadius=8.0
        nameTextField.layer.borderWidth=1.0
        
        youtubeID.layer.cornerRadius=8.0
        youtubeID.layer.borderWidth=1.0
        
        ingridients.layer.cornerRadius=8.0
        ingridients.layer.borderWidth=1.0
        
        super.viewDidLoad()
        
    }
    
 
    
       @IBAction func saveRecip(sender: AnyObject) {
        
        
        let profileRef = Database.database().reference()
        var handle: UInt = 0

        let name = nameTextField.text
        let ingr = ingridients.text

        if ( title=="" || ingr=="" || youtubeID.text=="" ){
            JSSAlertView().show(
                self,
                title: "Fel!!!",
                text: "Full i all former",
                buttonText: "OK",
                color: UIColorFromHex(0x9b59b6, alpha: 1))
        }
       else {
            let newRecipt: NSDictionary = ["duration":"2", "imageQuality": "mqdefault", "ingredients":ingr!, "title": name!, "youtubeID": self.youtubeID.text!, ]
            
            let profile = profileRef.ref.child("data").child(self.indexOfRowInDataPicker).child("category")
            
            
            
            //write data to Firebase
            
                handle = profile.observe(.value, with: { (snapshot: DataSnapshot!) in
                    
                profile.removeObserver(withHandle: handle)
                let newProfile = profile.childByAutoId
                newProfile().setValue(newRecipt)
                
                
            })
            
            self.dismiss(animated: true, completion: nil)
            
        }


    }
    
    func myCallback() {
        // this'll run after the alert is dismissed
    }
    
   
 

}
