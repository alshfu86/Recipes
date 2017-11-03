//
//  CategoryTableViewCell.swift
//  Recipe
//
//  Created by alsh on 10.10.17.
//  Copyright © 2017 wsoft. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var recipeImageView: UIImageView!
    
    @IBOutlet weak var recipeLabel: UILabel!
    
    
    override func awakeFromNib() {
        
        recipeImageView.layer.masksToBounds = true
        recipeImageView.layer.cornerRadius=8.0
        recipeImageView.layer.borderWidth=1.0
        
        recipeLabel.layer.masksToBounds = true
        recipeLabel.layer.cornerRadius=8.0
        recipeLabel.layer.borderWidth=1.0

        
        super.awakeFromNib()
        // Initialization code
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   

}
