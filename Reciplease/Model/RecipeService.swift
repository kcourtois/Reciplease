//
//  RecipeService.swift
//  Reciplease
//
//  Created by Kévin Courtois on 24/05/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

    //https://api.edamam.com/search?q=chicken&app_id=f7b6a07b&app_key=bf62a82ba3c9659ffaa76c91fdfe8d08

import Foundation
import Alamofire
import SwiftyJSON

enum NetworkError: Error {
    case failure
    case success
}

class RecipeService {
    var searchResults = [JSON]()

    func search(searchText: String, completionHandler: @escaping ([JSON]?, NetworkError) -> Void) {
        let urlToSearch =
        "http://api.edamam.com/search?q=\(searchText)&app_id=f7b6a07b&app_key=bf62a82ba3c9659ffaa76c91fdfe8d08"
        AF.request(urlToSearch).responseJSON { response in
            guard let data = response.data, let json = try? JSON(data: data) else {
                completionHandler(nil, .failure)
                print("fail")
                return
            }

            json["hits"].array?.forEach({ (hit) in
                let recipe = hit["recipe"]
                print(recipe["label"].stringValue)
                print(recipe["image"].stringValue)
            })

            completionHandler(nil, .success)
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
