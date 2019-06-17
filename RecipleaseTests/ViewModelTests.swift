//
//  IngredientModelTests.swift
//  RecipleaseTests
//
//  Created by Kévin Courtois on 11/06/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import XCTest
import Foundation
import Mockingjay
@testable import Reciplease

class IngredientViewModelTests: XCTestCase {
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

    func testGivenIngredientsWhenCallingSearchThenFillsRecipes() {
        let testExpectation = expectation(description: "Did finish operation expectation")
        let url = Bundle(for: type(of: self)).url(forResource: "NoFilters", withExtension: "json")!
        // swiftlint:disable:next force_try
        let data = try! Data(contentsOf: url)
        stub(MockingjayFilters.matcherNoFilters, jsonData(data))
        stub(MockingjayFilters.matcherImages, jsonData(UIColor.green.image().pngData()!))
        preferences.ingredients.append("- mozzarella")
        preferences.ingredients.append("- goat cheese")

        let handler = { (notification: Notification) -> Void in
            testExpectation.fulfill()
        }

        // swiftlint:disable:next discarded_notification_center_observer
        NotificationCenter.default.addObserver(forName: .didSendPerformSegue, object: nil, queue: nil, using: handler)

        model.searchRecipes()
        waitForExpectations(timeout: 10, handler: nil)

        XCTAssertFalse(model.recipes.isEmpty)
    }
}

class FiltersViewModelTests: XCTestCase {

    var model: FiltersViewModel!
    var preferences: Preferences!

    override func setUp() {
        preferences = Preferences(defaults: .makeClearedInstance())
        let filter = HealthFilter.getList()[0]
        model = FiltersViewModel(filter: filter, preferences: preferences)
    }

    func testGivenEmptyUserdefaultsThenActiveShouldBeFalse() {
        XCTAssertFalse(model.active)
    }

    func testGivenTagInUserdefaultsThenActiveShouldBeTrue() {
        preferences.filters.append(HealthFilter.getList()[0].tag)

        XCTAssertTrue(model.active)
    }

    func testGivenEmptyUserdefaultsWhenToggleSwitchThenActiveIsTrue() {
        XCTAssertFalse(model.active)

        model.toggleSwitch()

        XCTAssertTrue(model.active)
    }

    func testGivenTagInUserdefaultsWhenToggleSwitchThenThenActiveIsFalse() {
        preferences.filters.append(HealthFilter.getList()[0].tag)
        XCTAssertTrue(model.active)

        model.toggleSwitch()

        XCTAssertFalse(model.active)
    }
}
