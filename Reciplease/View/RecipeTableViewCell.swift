//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Kévin Courtois on 27/05/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var imageRecipe: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var servings: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var subtitle: UILabel!

    func configure(recipe: Recipe) {
        imageRecipe.image = recipe.image
        title.text = recipe.name.capitalized
        servings.text = "\(recipe.servings)"
        time.text = "\(recipe.time) m"
        var ingredientsLabel = ""
        for (index, ingr) in recipe.ingredients.enumerated() {
            if index == recipe.ingredients.count-1 {
                ingredientsLabel += "\(ingr)"
            } else {
                ingredientsLabel += "\(ingr), "
            }
        }
        subtitle.text = "\(ingredientsLabel)"
    }
}
