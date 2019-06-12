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

    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    public var ingredients: [String] {
        get {
            guard let res = defaults.object(forKey: Keys.ingredients) as? [String] else {
                return []
            }
            return res
        }
        set {
            defaults.set(newValue, forKey: Keys.ingredients)
        }
    }

    public var filters: [String] {
        get {
            guard let res = defaults.object(forKey: Keys.filters) as? [String] else {
                return []
            }
            return res
        }
        set {
            defaults.set(newValue, forKey: Keys.filters)
        }
    }
}
