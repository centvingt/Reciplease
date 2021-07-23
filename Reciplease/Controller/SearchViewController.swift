//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Vincent Caronnet on 18/07/2021.
//

import UIKit

class SearchViewController: UIViewController {
    private var ingredients = [String]()
    private var recipes: [Recipe]?
    
    private let recipeModel = RecipeModel()
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var buttonsStackView: UIStackView!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        tableView.backgroundColor = UIColor.recipeDarkGray
        
        ViewHelpers.setRoundedCornersOf(view: addButton)
        ViewHelpers.setRoundedCornersOf(view: clearButton)
        ViewHelpers.setRoundedCornersOf(view: searchButton)
        
        setButtonsVisibility()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "SegueToSearchResult" else { return }
        let viewController = segue.destination as! RecipeTableViewController
        
        guard let recipes = recipes else {
            present(
                RecipeAlert.getAlert(for: .noRecipeData),
                animated: true
            )
            return
        }
        
        viewController.screen = .searchResult
        viewController.recipes = recipes
    }
    
    private func addIngredient() {
        guard let ingredient = inputTextField.text?.trimmingCharacters(in: .whitespaces),
              !ingredient.isEmpty else { return }
        
        ingredients.append(ingredient)
        
        inputTextField.text = ""
        
        setButtonsVisibility()
        tableView.reloadData()
    }
    
    private func setButtonsVisibility() {
        buttonsStackView.isHidden = ingredients.isEmpty
    }
    
    // MARK: - Button's actions
    
    @IBAction func addButtonDidPressed(_ sender: UIButton) {
        addIngredient()
    }
    @IBAction func clearButtonDidPressed(_ sender: UIButton) {
        ingredients = []
        
        setButtonsVisibility()
        tableView.reloadData()
    }
    @IBAction func searchButtonDidPressed(_ sender: UIButton) {
        recipeModel.getRecipes(for: ingredients) { recipeError, recipes in
            if let recipeError = recipeError {
                self.present(
                    RecipeAlert.getAlert(for: recipeError),
                    animated: true
                )
            }
            
            guard let recipes = recipes else {
                self.present(
                    RecipeAlert.getAlert(for: .noRecipeData),
                    animated: true
                )
                return
            }
            
            self.recipes = recipes
            
            self.performSegue(withIdentifier: "SegueToSearchResult", sender: nil)
        }
    }
    
    // MARK: - Keyboard handling
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        return ingredients.isEmpty ? "" : "Your ingredients:"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell") else {
            return UITableViewCell()
        }
        cell.textLabel?.text = ingredients[indexPath.row]
        return cell
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == inputTextField {
            addIngredient()
            textField.resignFirstResponder()
            return false
        }
        return true
    }
}
