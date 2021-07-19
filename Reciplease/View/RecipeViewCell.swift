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
    
    var title = "Recipe title"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        titleLabel.text = title
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
