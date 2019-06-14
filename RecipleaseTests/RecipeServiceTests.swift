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
        stub(matcherImages, jsonData(UIColor.green.image().pngData()!))
    }

    func testGivenResearchWhenCallingSearchWithoutFiltersShouldHaveResultAndNoError() {
        let url = Bundle(for: type(of: self)).url(forResource: "NoFilters", withExtension: "json")!
        // swiftlint:disable:next force_try
        let data = try! Data(contentsOf: url)
        stub(matcherNoFilters, jsonData(data))

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
        stub(matcherFilters, jsonData(data))
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

    func matcherNoFilters(request: URLRequest) -> Bool {
        let urlToSearch =
            "http://api.edamam.com/search?q=mozzarella goat cheese" +
                "&app_id=\(ApiKeys.edamamAppId)&" +
        "app_key=\(ApiKeys.edamamKey)"

        guard let urlString = urlToSearch.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let urlDef = URL(string: urlString) else {
                return false
        }

        let requestToCompare = URLRequest(url: urlDef)

        return request.url == requestToCompare.url
    }

    func matcherFilters(request: URLRequest) -> Bool {
        let urlToSearch =
            "http://api.edamam.com/search?q=mozzarella goat cheese" +
            "&app_id=\(ApiKeys.edamamAppId)&" +
            "app_key=\(ApiKeys.edamamKey)" +
            "&health=alcohol-free&health=vegetarian"

        guard let urlString = urlToSearch.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let urlDef = URL(string: urlString) else {
                return false
        }

        let requestToCompare = URLRequest(url: urlDef)

        return request.url == requestToCompare.url
    }

    func matcherImages(request: URLRequest) -> Bool {

        //let baseUrl = "http://www.edamam.com/ontologies/edamam.owl#recipe"

        let baseUrl = "https://www.edamam.com/web-img/"

        guard let url = request.url else {
            return false
        }

        let requestBase = url.absoluteString.prefix(baseUrl.count)

        return baseUrl == requestBase
    }

}
