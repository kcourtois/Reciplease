//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Kévin Courtois on 27/05/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    @IBOutlet weak var recipeResume: RecipeResume!

    func configure(recipe: Recipe) {
        recipeResume.imageView.image = recipe.image
        recipeResume.title.text = recipe.name.capitalized
        recipeResume.servings.text = "\(recipe.servings)"
        recipeResume.time.text = "\(recipe.time) m"
        var ingredientsLabel = ""
        for (index, ingr) in recipe.ingredients.enumerated() {
            if index == recipe.ingredients.count-1 {
                ingredientsLabel += "\(ingr)"
            } else {
                ingredientsLabel += "\(ingr), "
            }
        }
        recipeResume.subtitle.text = "\(ingredientsLabel)"
    }
}
