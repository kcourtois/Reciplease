//
//  AlamofireTests.swift
//  RecipleaseTests
//
//  Created by Kévin Courtois on 03/06/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import XCTest
@testable import Reciplease
class RecipeServiceTests: XCTestCase {

    func testGivenResearchWhenCallingSearchWithoutFiltersShouldHaveResultAndNoError() {
        let expec = expectation(description: "Alamofire")

        RecipeService.shared.search(searchText: "mozzarella goat cheese") { (result, error) in
            XCTAssertEqual(error, .success)
            XCTAssertNotNil(result)
            expec.fulfill()
        }

        waitForExpectations(timeout: 10.0, handler: nil)
    }

    func testGivenResearchWhenCallingSearchWithFiltersShouldHaveResultAndNoError() {
        let expec = expectation(description: "Alamofire")
        let list = HealthFilter.getList()
        let preferences = Preferences(defaults: .makeClearedInstance())

        XCTAssertEqual(list.count, 6)
        preferences.filters.append(list[0].tag)
        preferences.filters.append(list[1].tag)

        RecipeService.shared.search(searchText: "mozzarella goat cheese") { (result, error) in
            XCTAssertEqual(error, .success)
            XCTAssertNotNil(result)
            expec.fulfill()
        }

        waitForExpectations(timeout: 10.0, handler: nil)
    }

}
