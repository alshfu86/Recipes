//
//  Recipe.swift
//  Recipes
//
//  Created by Admin on 03.11.17.
//  Copyright © 2017 wsoft. All rights reserved.
//

import Foundation
    class Recipe {
    var title : String
    var imageQuality : String
    var recipeIndex : String
    var youtubeID : String
    var ingredients : String
    var categoryIndex : String

    
    init(titleText:String, imageQualityString:String, recipeIndexString:String,youtubeIDString:String, ingredientsString: String, categoryIndexString: String ) {
        title = titleText
        imageQuality = imageQualityString
        recipeIndex = recipeIndexString
        youtubeID = youtubeIDString
        ingredients = ingredientsString
        categoryIndex = categoryIndexString
        

    }
//    init(titleText:String, imageQualityString:String, youtubeIDString:String, ingredientsString: String ) {
//        title = titleText
//        imageQuality = imageQualityString
//        youtubeID = youtubeIDString
//        ingredients = ingredientsString
//
//    }
//
}
