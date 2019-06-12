//
//  IngredientModelTests.swift
//  RecipleaseTests
//
//  Created by Kévin Courtois on 11/06/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import XCTest
import Foundation
@testable import Reciplease

class IngredientModelTests: XCTestCase {

    var model: IngredientViewModel!
    var preferences: Preferences!

    override func setUp() {
        preferences = Preferences(defaults: .makeClearedInstance())
        model = IngredientViewModel(preferences: preferences)
    }

    func testGivenEmptyUserdefaultsThenShouldReturnNone() {
        XCTAssertEqual(model.getFilters(), "Filters: None.")
    }

    func testGivenEmptyUserdefaultsThenShouldReturnFilters() {
        XCTAssertEqual(model.getFilters(), "Filters: None.")

        preferences.filters.append(HealthFilter.getList()[0].tag)
        preferences.filters.append(HealthFilter.getList()[5].tag)
        XCTAssertEqual(model.getFilters(), "Filters: alcohol-free, vegetarian.")
    }
}
