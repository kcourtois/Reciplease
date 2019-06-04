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
    func testGivenResearchWhenCallingSearchShouldHaveResultAndNoError() {
        let expec = expectation(description: "Alamofire")

        RecipeService.shared.search(searchText: "mozzarella goat cheese") { (result, error) in
            XCTAssertEqual(error, .success)
            XCTAssertNotNil(result, "No result")
            expec.fulfill()
        }

        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
