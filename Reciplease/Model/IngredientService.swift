//
//  IngredientService.swift
//  Reciplease
//
//  Created by Kévin Courtois on 31/05/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import Foundation

class IngredientService {

    private struct Keys {
        static let ingredients = "ingredients"
    }

    static var ingredients: [String] {
        get {
            guard let res = UserDefaults.standard.object(forKey: Keys.ingredients) as? [String] else {
                return []
            }
            return res
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.ingredients)
        }
    }
}
