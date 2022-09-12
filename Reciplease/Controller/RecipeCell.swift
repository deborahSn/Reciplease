//
//  RecipeCell.swift
//  Reciplease
//
//  Created by Déborah Suon on 04/08/2022.
//

import Foundation
import UIKit

class RecipeCell: UITableViewCell {
    
    @IBOutlet weak var titleRecipe: UILabel!
    @IBOutlet weak var ingredientsRecipe: UILabel!
    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var time: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    ///RecipleaseCoreData initalisation
    var recipe: Recipe? {
        didSet {
            titleRecipe.text = recipe?.label.localizedCapitalized
            ingredientsRecipe.text = recipe?.ingredientLines.joined(separator: ", ")
            imageRecipe.load(urlImageString: recipe?.image)
            time.text = (recipe?.totalTime ?? 0).convertTimeToString
            print("\(recipe?.totalTime ?? 0)")
        }
    }
    
    var recipleaseCoreData: RecipleaseCoreData? {
        didSet {
            titleRecipe.text = recipleaseCoreData?.title
            ingredientsRecipe.text = recipleaseCoreData?.ingredients
            imageRecipe.load(urlImageString: recipleaseCoreData?.image)
            time.text = (recipe?.totalTime ?? 0).convertTimeToString
            time.text = Int(recipleaseCoreData?.time ?? 0).convertTimeToString
        }
    }
    
    func setupCell() {
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOpacity = 0.25
    }
}
