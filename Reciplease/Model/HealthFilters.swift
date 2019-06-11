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

    private init(tag: String, title: String, description: String, active: Bool) {
        self.tag = tag
        self.title = title
        self.description = description
    }

    static func getList() -> [HealthFilter] {
        return [
        HealthFilter(tag: "alcohol-free", title: "Alcohol-free", description: "No alcohol used or contained"),
        HealthFilter(tag: "peanut-free", title: "Peanuts-free",
                     description: "No peanuts or products containing peanuts"),
        HealthFilter(tag: "sugar-conscious", title: "Sugar-conscious",
                     description: "Less than 4g of sugar per serving"),
        HealthFilter(tag: "tree-nut-free", title: "Tree Nuts",
                     description: "No tree nuts or products containing tree nuts"),
        HealthFilter(tag: "vegan", title: "Vegan", description: "No meat, poultry, fish, dairy, eggs or honey"),
        HealthFilter(tag: "vegetarian", title: "Vegetarian", description: "No meat, poultry, or fish")
        ]
    }
}
