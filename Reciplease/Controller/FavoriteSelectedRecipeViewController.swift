//
//  FavoriteSelectedRecipeViewController.swift
//  Reciplease
//
//  Created by Déborah Suon on 06/06/2022.
//

import Foundation
import UIKit


class FavoriteSelectedRecipeViewController: UIViewController {
    
    @IBOutlet weak var titleRecipe: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var ingredients: UITextView!
    @IBOutlet weak var webDirection: UIButton!
    @IBOutlet weak var favoriteItem: UIBarButtonItem!
    
    var cellule: RecipleaseCoreData?
    private var coreDataManager: CoreDataManager?
    var recipeIsFavorite : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataFunction()
        configRecipe()
        checkIfRecipeIsFavorite()
    }
    
    @IBAction private func favoritesBarButtonItemTapped(_ sender: UIBarButtonItem){
        checkIfRecipeIsFavorite()
        deleteRecipeOfFavorite(recipeTitle: cellule?.title,
                             url: cellule?.url,
                             coreDataManager: coreDataManager,
                             barButtonItem: favoriteItem)
        navigationController?.popViewController(animated: true)
    }

    @IBAction private func redirectionURLWeb(_ sender: UIButton) {
        guard let celluleRecipeUrl = cellule?.url else { return }
        redirectionURL(urlString: celluleRecipeUrl)
    }
    
    private func coreDataFunction() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    private func configRecipe() {
        ingredients.text = cellule?.ingredients
        titleRecipe.text = cellule?.title
        image.load(urlImageString: cellule?.image)
    }
    
    func checkIfRecipeIsFavorite() {
        guard let recipeTitle = cellule?.title else { return }
        guard let url = cellule?.url else { return }
        guard let checkIsRecipeIsFavorite = coreDataManager?.checkIfRecipeIsFavorite(title: recipeTitle, url: url) else { return }
        
        recipeIsFavorite = checkIsRecipeIsFavorite
        
        if recipeIsFavorite {
            favoriteItem.tintColor = .yellow
        } else {
            favoriteItem.tintColor = .none
        }
    }
    
    func deleteRecipeOfFavorite(recipeTitle: String?, url: String?, coreDataManager: CoreDataManager?, barButtonItem: UIBarButtonItem) {
        coreDataManager?.deleteRecipe(recipeTitle: recipeTitle ?? "", url: url ?? "")
        setupBarButtonItem(color: .white, barButtonItem: favoriteItem)
    }
    func setupBarButtonItem(color: UIColor, barButtonItem: UIBarButtonItem) {
        barButtonItem.tintColor = color
        navigationItem.rightBarButtonItem = barButtonItem
    }
}
    
