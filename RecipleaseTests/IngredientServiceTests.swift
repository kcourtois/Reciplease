//
//  IngredientServiceTests.swift
//  RecipleaseTests
//
//  Created by Kévin Courtois on 31/05/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import XCTest

@testable import Reciplease

class IngredientServiceTests: XCTestCase {
    func testGivenEmptyUserdefaultsWhenAddingIngredientThenShouldUpdate() {

        let preferences = Preferences(defaults: .makeClearedInstance())

        preferences.ingredients.append("Potatoe")
        preferences.ingredients.append("Cheese")

        XCTAssertEqual(preferences.ingredients[0], "Potatoe")
        XCTAssertEqual(preferences.ingredients[1], "Cheese")
    }
}
