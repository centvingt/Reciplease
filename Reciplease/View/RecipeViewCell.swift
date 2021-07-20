//
//  RecipeViewCell.swift
//  Reciplease
//
//  Created by Vincent Caronnet on 18/07/2021.
//

import UIKit

class RecipeViewCell: UITableViewCell {
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var recipeImageView: UIImageView!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    var title = "Recipe title"
    var calories: Double = 0.0
    var imageURL = "https://www.edamam.com/web-img/e42/e42f9119813e890af34c259785ae1cfb.jpg"
    var totalTime: Float = 120.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    func configure() {
        titleLabel.text = title
        caloriesLabel.text = "\(Int(calories)) kcal"
        ImageLoader.load(stringUrl: imageURL, imageView: recipeImageView)
        totalTimeLabel.text = "\(Int(totalTime)) min"
    }
}
