//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Vincent Caronnet on 20/07/2021.
//

import UIKit

class RecipeDetailViewController: UIViewController {
    var recipe: Recipe?
    let recipeModel = RecipeModel()
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.backgroundColor = UIColor.recipeDarkGrey
        ViewHelpers.setRoundedCornersOf(view: getDirectionsButton)
        
        setFavoriteButtonIcon()
        
        guard let recipe = recipe else {
            return
        }
        ImageLoader.load(stringUrl: recipe.image, imageView: recipeImageView)
        titleLabel.text = recipe.label
        totalTimeLabel.text = "\(Int(recipe.totalTime)) min"
    }
    
    @IBAction func getDirectionsButtonDidPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "SegueToDirections", sender: nil)
    }
    
    @IBAction func favoriteButtonDidPressed(_ sender: Any) {
        guard let recipe = recipe else { return }
        recipeModel.setFavorite(for: recipe)
        
        setFavoriteButtonIcon()
    }
    
    private func setFavoriteButtonIcon() {
        guard let recipe = recipe else { return }
        favoriteButton.image = recipeModel.recipeIsFavorite(recipe)
            ? UIImage(systemName: "star.fill")
            : UIImage(systemName: "star")
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        guard segue.identifier == "SegueToDirections" else { return }
        let viewController = segue.destination as! DirectionsViewController
        
        guard let recipe = recipe else {
            return
        }
        
        viewController.recipeURL = recipe.url
    }
}

extension RecipeDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipe = recipe else {
            return 0
        }
        return recipe.ingredientLines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell"),
            let recipe = recipe
        else {
            return UITableViewCell()
        }
        cell.textLabel?.text = recipe.ingredientLines[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        guard let recipe = recipe else { return "" }
        return recipe.ingredientLines.isEmpty ? "" : "Your ingredients:"
    }
}
