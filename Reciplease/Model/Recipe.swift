//
//  Recipe.swift
//  Reciplease
//
//  Created by Kévin Courtois on 27/05/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import Foundation
import UIKit

class Recipe {
    let name: String
    let image: UIImage
    let time: Int
    let servings: Int
    let ingredients: [String]
    let source: String

    init(name: String, image: UIImage, time: Int, servings: Int, ingredients: [String], source: String) {
        self.name = name
        self.image = image
        self.time = time
        self.servings = servings
        self.ingredients = ingredients
        self.source = source
    }

    convenience init?(favorite: FavoriteRecipe) {
        guard let name = favorite.name,
            let imgData = favorite.image,
            let ingredients = favorite.ingredients,
            let source = favorite.source else {
                return nil
        }

        guard let image = UIImage(data: imgData) else {
            return nil
        }

        self.init(name: name, image: image, time: Int(favorite.time), servings: Int(favorite.servings),
                      ingredients: ingredients, source: source)
    }
}
