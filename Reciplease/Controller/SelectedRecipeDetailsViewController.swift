//
//  SelectedRecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Déborah Suon on 08/05/2022.
//

import Foundation
import UIKit


class SelectedRecipeDetailsViewController: UIViewController {
    @IBOutlet private weak var urlButton: UIButton!
    @IBOutlet private weak var recipeImageView: UIImageView!
    @IBOutlet private weak var titleRecipeLabel: UILabel!
    @IBOutlet private weak var ingredientsTextView: UITextView!
    
    @IBOutlet weak var favoriteItem: UIBarButtonItem!
    
    var cellule: Hit?
    private var coreDataManager: CoreDataManager?
    var recipeIsFavorite : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataFunction()
        configRecipe()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkIfRecipeIsFavorite()
    }
    
    @IBAction func addRecipeFAvorite(_ sender: UIBarButtonItem){
        print("addFavoriteItem")
        checkIfRecipeIsFavorite()
        !recipeIsFavorite ? addRecipeToFavorites() : deleteRecipeFavorite(recipeTitle: cellule?.recipe.label,
                                url: cellule?.recipe.url,
                                coreDataManager: coreDataManager,
                                barButtonItem: favoriteItem)
    }
    
    @IBAction private func redirectionWebButton(_ sender: UIButton) {
        guard let celluleRecipeUrl = cellule?.recipe.url else { return }
        redirectionURL(urlString: celluleRecipeUrl)
    }

    ///
    private func coreDataFunction() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    private func configRecipe() {
        guard let ingredientLines = cellule?.recipe.ingredientLines.joined(separator: "\n" + "- ") else { return }
        guard let image = cellule?.recipe.image else { return }
        recipeImageView.load(urlImageString: image)
        ingredientsTextView.text = "- " + ingredientLines
        titleRecipeLabel.text = cellule?.recipe.label.localizedCapitalized
    }
    
    func addRecipeToFavorites() {
        guard let label = cellule?.recipe.label else { return }
        guard let ingredients = cellule?.recipe.ingredientLines.joined(separator: "\n" + "- ") else { return }
        guard let image = cellule?.recipe.image else { return }
        guard let url = cellule?.recipe.url else { return }
        guard let time = cellule?.recipe.totalTime else { return }
        coreDataManager?.createTask(title: label.localizedCapitalized,
                                      ingredients: "- " + ingredients,
                                      image: image,
                                      url: url,
                                      time: time)

        setupBarButtonItem(color: .yellow, barButtonItem: favoriteItem)
    }
    
    func setupBarButtonItem(color: UIColor, barButtonItem: UIBarButtonItem) {
        barButtonItem.tintColor = color
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    func checkIfRecipeIsFavorite() {
        guard let recipeTitle = cellule?.recipe.label else { return }
        guard let url = cellule?.recipe.url else { return }
        guard let checkIsRecipeIsFavorite = coreDataManager?.checkIfRecipeIsFavorite(title: recipeTitle, url: url) else { return }
        
        recipeIsFavorite = checkIsRecipeIsFavorite
        
        if recipeIsFavorite {
            favoriteItem.tintColor = UIColor.yellow
        } else {
            favoriteItem.tintColor = .none
        }
    }
    
    func deleteRecipeFavorite(recipeTitle: String?, url: String?, coreDataManager: CoreDataManager?, barButtonItem: UIBarButtonItem) {
        coreDataManager?.deleteRecipe(recipeTitle: recipeTitle ?? "", url: url ?? "")
        setupBarButtonItem(color: .white, barButtonItem: favoriteItem)
    }
}






    
