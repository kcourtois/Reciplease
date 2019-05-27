//
//  RecipeService.swift
//  Reciplease
//
//  Created by Kévin Courtois on 24/05/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

enum NetworkError: Error {
    case failure
    case success
}

class RecipeService {
    var searchResults = [JSON]()

    func search(searchText: String, completionHandler: @escaping ([Recipe]?, NetworkError) -> Void) {
        let urlToSearch =
        "http://api.edamam.com/search?q=\(searchText)&app_id=f7b6a07b&app_key=bf62a82ba3c9659ffaa76c91fdfe8d08"
        AF.request(urlToSearch).responseJSON { response in
            guard let data = response.data, let json = try? JSON(data: data), let arr = json["hits"].array else {
                completionHandler(nil, .failure)
                print("fail")
                return
            }

            var recipes: [Recipe] = []

            for (index, hit) in arr.enumerated() {
                let recipeJSON = hit["recipe"]
                self.fetchImage(url: recipeJSON["image"].stringValue, completionHandler: { (result, success) in

                    guard let img = result, success == .success else {
                        completionHandler(nil, .failure)
                        return
                    }

                    let stringArr: [String] = recipeJSON["ingredientLines"].arrayValue.map { $0.stringValue}

                    let recipe = Recipe(name: recipeJSON["label"].stringValue, image: img,
                                        time: recipeJSON["totalTime"].intValue,
                                        servings: recipeJSON["yield"].intValue, ingredients: stringArr,
                                        source: recipeJSON["url"].stringValue)

                    recipes.append(recipe)

                    if index == arr.count-1 {
                        completionHandler(recipes, .success)
                    }
                })
            }
        }
    }

    func fetchImage(url: String, completionHandler: @escaping (UIImage?, NetworkError) -> Void) {
        AF.request(url).responseData { responseData in

            guard let imageData = responseData.data else {
                completionHandler(nil, .failure)
                return
            }

            guard let image = UIImage(data: imageData) else {
                completionHandler(nil, .failure)
                return
            }

            completionHandler(image, .success)
        }
    }
}
