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
        IngredientService.ingredients.append("Potatoe")
        IngredientService.ingredients.append("Cheese")

        XCTAssertEqual(IngredientService.ingredients[0], "Potatoe")
        XCTAssertEqual(IngredientService.ingredients[1], "Cheese")
    }
}
