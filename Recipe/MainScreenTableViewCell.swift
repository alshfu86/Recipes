//
//  MainScreenTableViewCell.swift
//  Recipe
//
//  Created by alsh on 10.10.17.
//  Copyright © 2017 wsoft. All rights reserved.
//

import UIKit

class MainScreenTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var mealCategoryLabel: UILabel!
    

    override func awakeFromNib() {
        mealCategoryLabel.layer.masksToBounds = true
        mealCategoryLabel.layer.cornerRadius=8.0
        mealCategoryLabel.layer.borderWidth=1.0
        backgroundImageView.layer.masksToBounds=true
        backgroundImageView.layer.cornerRadius=8.0
        backgroundImageView.layer.borderWidth=1.0
        
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
