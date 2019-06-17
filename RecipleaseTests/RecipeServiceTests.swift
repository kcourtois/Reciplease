//
//  AlamofireTests.swift
//  RecipleaseTests
//
//  Created by Kévin Courtois on 03/06/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import XCTest
import Mockingjay
@testable import Reciplease
class RecipeServiceTests: XCTestCase {

    var preferences: Preferences!

    override func setUp() {
        super.setUp()
        preferences = Preferences(defaults: .makeClearedInstance())
        stub(MockingjayFilters.matcherImages, jsonData(UIColor.green.image().pngData()!))
    }

    func testGivenResearchWhenCallingSearchWithoutFiltersShouldHaveResultAndNoError() {
        let url = Bundle(for: type(of: self)).url(forResource: "NoFilters", withExtension: "json")!
        // swiftlint:disable:next force_try
        let data = try! Data(contentsOf: url)
        stub(MockingjayFilters.matcherNoFilters, jsonData(data))

        let expec = expectation(description: "Alamofire")

        RecipeService.shared.search(preferences: preferences, searchText: "mozzarella goat cheese") { (result, error) in
            XCTAssertEqual(error, .success)
            XCTAssertNotNil(result)
            expec.fulfill()
        }

        wait(for: [expec], timeout: 10)
    }

    func testGivenResearchWhenCallingSearchWithFiltersShouldHaveResultAndNoError() {
        let url = Bundle(for: type(of: self)).url(forResource: "Filters", withExtension: "json")!
        // swiftlint:disable:next force_try
        let data = try! Data(contentsOf: url)
        stub(MockingjayFilters.matcherFilters, jsonData(data))
        let expec = expectation(description: "Alamofire")
        let list = HealthFilter.getList()

        XCTAssertEqual(list.count, 6)
        preferences.filters.append(list[0].tag)
        preferences.filters.append(list[5].tag)

        RecipeService.shared.search(preferences: preferences, searchText: "mozzarella goat cheese") { (result, error) in
            XCTAssertEqual(error, .success)
            XCTAssertNotNil(result)
            expec.fulfill()
        }

        wait(for: [expec], timeout: 10)
    }
}
