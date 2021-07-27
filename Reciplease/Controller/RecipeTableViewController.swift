//
//  RecipeTableViewController.swift
//  Reciplease
//
//  Created by Vincent Caronnet on 18/07/2021.
//

import UIKit

class RecipeTableViewController: UITableViewController {
    var recipes = [Recipe]()
    var selectedRecipe: Recipe?
    
    var recipeModel = RecipeModel()
    
    var screen = Screen.favorites
    
    enum Screen {
        case favorites, searchResult
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor.recipeDarkGray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if screen == .favorites {
            guard let recipes = recipeModel.getFavorites() else {
                self.recipes = []
                tableView.reloadData()
                return
            }
            self.recipes = recipes
        }
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if screen == .favorites && recipes.isEmpty {
            return 1
        }
        return recipes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if screen == .favorites && recipes.isEmpty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "InstructionsCell") else {
                return UITableViewCell()
            }
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell") as? RecipeViewCell else {
            return UITableViewCell()
        }
        
        let recipe = recipes[indexPath.row]
        
        cell.title = recipe.label
        cell.calories = recipe.calories
        cell.imageURL = recipe.image
        cell.totalTime = recipe.totalTime
        
        cell.configure()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if screen == .favorites && recipes.isEmpty {
            return UITableView.automaticDimension
        }
        return tableView.frame.width * 0.5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedRecipe = recipes[indexPath.row]
        performSegue(withIdentifier: "SegueToRecipeDetail", sender: nil)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard segue.identifier == "SegueToRecipeDetail" else { return }
        let viewController = segue.destination as! RecipeDetailViewController
        
        guard let selectedRecipe = selectedRecipe else {
            return
        }
        
        viewController.recipe = selectedRecipe
    }
}
