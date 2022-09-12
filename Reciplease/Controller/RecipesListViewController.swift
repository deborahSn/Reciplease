//
//  RecipesListViewController.swift
//  Reciplease
//
//  Created by Déborah Suon on 08/05/2022.
//

import Foundation
import UIKit


class RecipesListViewController : UIViewController {
    
    @IBOutlet private weak var myTableView: UITableView!
    
    var recipesList = [Hit]()
    private var cellSelected: Hit?
    private let segueToRecipeDetail = "segueToRecipeDetail"

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        let nib = UINib(nibName: "RecipeCell", bundle: nil)
        myTableView.register(nib, forCellReuseIdentifier: "RecipeCell")
    }
}

extension RecipesListViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listRecipesCell = tableView.dequeueReusableCell(
            withIdentifier: "RecipeCell",
            for: indexPath) as? RecipeCell else {
            return UITableViewCell()
        }
        
        let recipe = recipesList[indexPath.row]
        listRecipesCell.recipe = recipe.recipe
        
        return listRecipesCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cellSelected = recipesList[indexPath.row]
        performSegue(withIdentifier: self.segueToRecipeDetail, sender: self)
    }
}

extension RecipesListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToRecipeDetail {
            guard let detailRecipeVC = segue.destination as? SelectedRecipeDetailsViewController else { return }
            detailRecipeVC.cellule = self.cellSelected
        }
    }
}

