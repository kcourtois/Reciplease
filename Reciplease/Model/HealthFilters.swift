//
//  HealthFilters.swift
//  Reciplease
//
//  Created by Kévin Courtois on 05/06/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import Foundation

class HealthFilter {
    let tag: String
    let title: String
    let description: String
    var active: Bool

    private init(tag: String, title: String, description: String, active: Bool) {
        self.tag = tag
        self.title = title
        self.description = description
        self.active = active
    }
    // swiftlint:disable:next function_body_length
    static func getList() -> [HealthFilter] {
        return [
        HealthFilter(tag: "alcohol-free", title: "Alcohol-free", description: "No alcohol used or contained",
                     active: false),
        HealthFilter(tag: "celery-free", title: "Celery-free",
                     description: "Does not contain celery or derivatives", active: false),
        HealthFilter(tag: "crustacean-free", title: "Crustacean-free",
                     description: "Does not contain crustaceans (shrimp, lobster etc.) or derivatives", active: false),
        HealthFilter(tag: "dairy-free", title: "Dairy-free", description: "No dairy; no lactose", active: false),
        HealthFilter(tag: "egg-free", title: "Eggs-free", description: "No eggs or products containing eggs",
                     active: false),
        HealthFilter(tag: "fish-free", title: "Fish-free", description: "No fish or fish derivatives", active: false),
        HealthFilter(tag: "gluten-free", title: "Gluten-free", description: "No ingredients containing gluten",
                     active: false),
        HealthFilter(tag: "keto-friendly", title: "Keto", description: "Maximum 7 grams of net carbs per serving",
                     active: false),
        HealthFilter(tag: "kidney-friendly", title: "Kidney friendly",
                     description: "Per serving – phosphorus less than 250 mg AND potassium less than 500 mg" +
                        "AND sodium: less than 500 mg", active: false),
        HealthFilter(tag: "kosher", title: "Kosher",
                     description: "Contains only ingredients allowed by the kosher diet. However it does not"
                        + "guarantee kosher preparation of the ingredients themselves", active: false),
        HealthFilter(tag: "low-potassium", title: "Low potassium", description: "Less than 150mg per serving",
                     active: false),
        HealthFilter(tag: "lupine-free", title: "Lupine-free",
                     description: "Does not contain lupine or derivatives", active: false),
        HealthFilter(tag: "mustard-free", title: "Mustard-free",
                     description: "Does not contain mustard or derivatives", active: false),
        HealthFilter(tag: "no-oil-added", title: "No oil added",
                     description: "No oil added except to what is contained in the basic ingredients", active: false),
        HealthFilter(tag: "low-sugar", title: "No-sugar", description: "No simple sugars – glucose, dextrose," +
            "galactose, fructose, sucrose, lactose, maltose", active: false),
        HealthFilter(tag: "paleo", title: "Paleo", description: "Excludes what are perceived to be agricultural" +
            "products; grains, legumes, dairy products, potatoes, " +
            "refined salt, refined sugar, and processed oils", active: false),
        HealthFilter(tag: "peanut-free", title: "Peanuts-free",
                     description: "No peanuts or products containing peanuts", active: false),
        HealthFilter(tag: "pescatarian", title: "Pescatarian",
                     description: "Does not contain meat or meat based products, can contain dairy and fish",
                     active: false),
        HealthFilter(tag: "pork-free", title: "Pork-free", description: "Does not contain pork or derivatives",
                     active: false),
        HealthFilter(tag: "red-meat-free", title: "Red meat-free", description: "Does not contain beef, lamb," +
            "pork, duck, goose, game, horse, and other types of red meat or products containing red meat.",
                     active: false),
        HealthFilter(tag: "sesame-free", title: "Sesame-free",
                     description: "Does not contain sesame seed or derivatives", active: false),
        HealthFilter(tag: "shellfish-free", title: "Shellfish", description: "No shellfish or shellfish derivatives",
                     active: false),
        HealthFilter(tag: "soy-free", title: "Soy", description: "No soy or products containing soy", active: false),
        HealthFilter(tag: "sugar-conscious", title: "Sugar-conscious",
                     description: "Less than 4g of sugar per serving", active: false),
        HealthFilter(tag: "tree-nut-free", title: "Tree Nuts",
                     description: "No tree nuts or products containing tree nuts", active: false),
        HealthFilter(tag: "vegan", title: "Vegan", description: "No meat, poultry, fish, dairy, eggs or honey",
                     active: false),
        HealthFilter(tag: "vegetarian", title: "Vegetarian", description: "No meat, poultry, or fish", active: false),
        HealthFilter(tag: "wheat-free", title: "Wheat-free", description: "No wheat, can have gluten though",
                     active: false)
        ]
    }
}
