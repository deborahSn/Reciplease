//
//  FavoriteRecipesListViewController.swift
//  Reciplease
//
//  Created by Déborah Suon on 23/05/2022.
//

import Foundation
import UIKit


class FavoriteRecipesListViewController: UIViewController{
    
    @IBOutlet weak var favoriteTableView: UITableView!
    @IBOutlet weak var viewEmptyTableView: UIView!
    
    var coreDataManager: CoreDataManager?
    var cellSelected: RecipleaseCoreData?
    var segueIdentifier = "FavoriteListIdentifier"
    
    override func viewDidLoad() {
         super.viewDidLoad()
        coreDataFunction()
        favoriteTableView.delegate = self
        favoriteTableView.dataSource = self
            // load nib cell
        let nib = UINib(nibName: "RecipeCell", bundle: nil)
        favoriteTableView.register(nib, forCellReuseIdentifier: "RecipeCell")
        favoriteTableView.reloadData()
        emptyTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoriteTableView.reloadData()
        emptyTableView()
    }
    
    private func coreDataFunction() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coreDataStack = appDelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coreDataStack)
    }
    
    func emptyTableView() {
        if favoriteTableView.numberOfRows(inSection: 0) > 0 {
            viewEmptyTableView.isHidden = true
        } else {
            viewEmptyTableView.isHidden = false
        }
    }
}

extension FavoriteRecipesListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return coreDataManager?.recipes.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listRecipesCell = tableView.dequeueReusableCell(
            withIdentifier: "RecipeCell",
            for: indexPath) as? RecipeCell else {
            return UITableViewCell()
        }
        let recipe = coreDataManager?.recipes[indexPath.row]
        listRecipesCell.recipleaseCoreData = recipe
        return listRecipesCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cellSelected = coreDataManager?.recipes[indexPath.row]
        performSegue(withIdentifier: self.segueIdentifier, sender: self)
    }
}

extension FavoriteRecipesListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueIdentifier {
            guard let favoriteListVC = segue.destination
                as? FavoriteSelectedRecipeViewController else { return }
            favoriteListVC.cellule = self.cellSelected
        }
    }
}
