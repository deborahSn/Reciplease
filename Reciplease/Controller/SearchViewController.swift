//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Déborah Suon on 28/01/2022.
//

import UIKit


class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var addIngredient: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchRecipeButton: UIButton!
    @IBOutlet weak var mytableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        mytableView.delegate = self
        mytableView.dataSource = self
        hiddeClearButton()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mytableView.reloadData()
        hiddeClearButton()
    }

    @IBAction func addIngredient(_ sender: Any) {
        addIngredientToTheList()
        searchTextField.resignFirstResponder()
        mytableView.reloadData()
    }
    
    @IBAction func clearButton(_ sender: Any) {
        ingredientsList.removeAll()
        mytableView.reloadData()
        hiddeClearButton()
    }
    
    @IBAction func searchRecipeButton(_ sender: Any) {
        getRecipes()
    }

    private let recipleaseService = RecipleaseService()
    private var ingredientsList = [String]()
    private var recipesList = [Hit]()
    /// segue to next VC
    private let segueToRecipesList = "segueToRecipesListVC"


    private func getRecipes() {
        /// if [ingredientList] n'est pas vide
        if ingredientsList.isEmpty {
            let alert = UIAlertController(title: "No ingredient", message: "Add an ingredient !", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        } else {
            /// network call
            recipleaseService.getRecipes(ingredientsList: ingredientsList) { (success, recipesSearch) in
                print("recipleaseService.getRecipes")
                if success {
                    guard let recipesSearch = recipesSearch else { return }
                    self.recipesList = recipesSearch.hits
                    self.performSegue(withIdentifier: self.segueToRecipesList, sender: self)
                    print("success test")
                } else {
                    print("error test")
                }
            }
        }
    }
    
    /// func to add ingredient from textField to [ingredientsList]
    func addIngredientToTheList(){
        guard let ingredient = searchTextField?.text else { return }
        ingredientsList.append(ingredient)
        mytableView.reloadData()
        print("add--")
    }
    /// func to hidde "clear_button" if tableView is empty
    func hiddeClearButton() {
        if mytableView.numberOfRows(inSection: 0) > 0 {
            clearButton.isHidden = false
        } else {
            clearButton.isHidden = true
        }
    }
    
}

extension SearchViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        searchTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("textFieldShouldReturn--")
        searchTextField.resignFirstResponder()
        return true
    }
}


extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredientsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyTableViewCell
        else {
            return UITableViewCell()
        }
        let ingredient = ingredientsList[indexPath.row]
        cell.setupCell(withIngredient: ingredient)
        print("cell--")

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// delete a row in tableView
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ingredientsList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension SearchViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToRecipesList {
            guard let listRecipesVC = segue.destination as? RecipesListViewController else { return }
            listRecipesVC.recipesList = recipesList
        }
    }
}

/// CUSTOM CLASS: cell
class MyTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var ingredientLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(withIngredient ingredient: String) {
        ingredientLabel?.text = "  - " + ingredient.localizedCapitalized
    }
}
