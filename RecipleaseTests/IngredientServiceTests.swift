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
    override func setUp() {
        UserDefaults.standard.removeObject(forKey: "ingredients")
    }

    override func tearDown() {
        UserDefaults.standard.removeObject(forKey: "ingredients")
    }

    func testGivenEmptyUserdefaultsWhenAddingIngredientThenShouldUpdate() {
        Preferences.ingredients.append("Potatoe")
        Preferences.ingredients.append("Cheese")

        XCTAssertEqual(Preferences.ingredients[0], "Potatoe")
        XCTAssertEqual(Preferences.ingredients[1], "Cheese")
    }
}
