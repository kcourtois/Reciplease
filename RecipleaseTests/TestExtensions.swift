//
//  TestExtensions.swift
//  RecipleaseTests
//
//  Created by Kévin Courtois on 12/06/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import Foundation
import Mockingjay
import UIKit
@testable import Reciplease

//Extends UserDefaults to use easily empty ones in tests
extension UserDefaults {
    static func makeClearedInstance(
        for functionName: StaticString = #function,
        inFile fileName: StaticString = #file
        ) -> UserDefaults {
        let className = "\(fileName)".split(separator: ".")[0]
        let testName = "\(functionName)".split(separator: "(")[0]
        let suiteName = "com.kcourtois.test.\(className).\(testName)"

        let defaults = self.init(suiteName: suiteName)!
        defaults.removePersistentDomain(forName: suiteName)
        return defaults
    }
}

//Extends UIColor to be able to create a UIImage based on a color
extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}

//Extension for filters (mockingjay)
class MockingjayFilters {
    static func matcherNoFilters(request: URLRequest) -> Bool {
        let urlToSearch =
            "http://api.edamam.com/search?q=mozzarella goat cheese" +
                "&app_id=\(ApiKeys.edamamAppId)&" +
        "app_key=\(ApiKeys.edamamKey)"

        guard let urlString = urlToSearch.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let urlDef = URL(string: urlString) else {
                return false
        }

        let requestToCompare = URLRequest(url: urlDef)
        print("MEYDEN: \(requestToCompare) \(request)")

        return request.url == requestToCompare.url
    }

    static func matcherFilters(request: URLRequest) -> Bool {
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

    static func matcherImages(request: URLRequest) -> Bool {

        //let baseUrl = "http://www.edamam.com/ontologies/edamam.owl#recipe"

        let baseUrl = "https://www.edamam.com/web-img/"

        guard let url = request.url else {
            return false
        }

        let requestBase = url.absoluteString.prefix(baseUrl.count)

        return baseUrl == requestBase
    }
}
