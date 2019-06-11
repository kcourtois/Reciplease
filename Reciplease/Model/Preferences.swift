//
//  FilterPreferences.swift
//  Reciplease
//
//  Created by Kévin Courtois on 10/06/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import Foundation

class Preferences {

    private struct Keys {
        static let ingredients = "ingredients"
        static let filters = "filters"
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

    static var filters: [String] {
        get {
            guard let res = UserDefaults.standard.object(forKey: Keys.filters) as? [String] else {
                return []
            }
            return res
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.filters)
        }
    }
}
