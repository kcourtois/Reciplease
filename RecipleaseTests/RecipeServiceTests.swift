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

        RecipeService.shared.search(searchText: "mozzarella goat cheese", filters: []) { (result, error) in
            XCTAssertEqual(error, .success)
            XCTAssertNotNil(result, "No result")
            expec.fulfill()
        }

        waitForExpectations(timeout: 10.0, handler: nil)
    }

    func testGivenResearchWhenCallingSearchWithFiltersShouldHaveResultAndNoError() {
        let expec = expectation(description: "Alamofire")
        let list = HealthFilter.getList()
        XCTAssertEqual(list.count, 28)
        let filters = [list[0].tag, list[26].tag]
        print(filters)

        RecipeService.shared.search(searchText: "mozzarella goat cheese",
                                    filters: filters) { (result, error) in
            XCTAssertEqual(error, .success)
            XCTAssertNotNil(result, "No result")
            expec.fulfill()
        }

        waitForExpectations(timeout: 10.0, handler: nil)
    }

}
