//
//  IngredientViewModel.swift
//  Reciplease
//
//  Created by Kévin Courtois on 11/06/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import Foundation
import UIKit

class IngredientViewModel {
    public var recipes: [Recipe] = []
    private var preferences: Preferences

    init(preferences: Preferences) {
        self.preferences = preferences
    }

    public func getFilters() -> String {
        if preferences.filters.isEmpty {
            return "Filters: None."
        } else {
            var text = "Filters: "
            for (index, tag) in preferences.filters.enumerated() {
                if index == preferences.filters.count-1 {
                    text += tag+"."
                } else {
                    text += tag+", "
                }
            }
            return text
        }
    }

    public func searchRecipes(alert: UIAlertController) {
        var search = ""
        for ingredient in preferences.ingredients {
            //Remove "- " from ingredient text
            let index = ingredient.index(ingredient.endIndex, offsetBy: -ingredient.count+2)
            let substring = ingredient[index...]
            search += " " + String(substring)
        }

        //API Call to search recipes
        RecipeService.shared.search(searchText: search) { (result, success) in
            //end of api calls, dimiss loading alert
            alert.dismiss(animated: false) {
                guard let res = result, success == .success else {
                    self.postErrorAlert(message: "Couldn't handle your request. Try again later.")
                    return
                }

                self.recipes = res
                self.postPerformSegue()
            }
        }
    }

    private func postPerformSegue() {
        NotificationCenter.default.post(Notification(name: .didSendPerformSegue))
    }

    private func postErrorAlert(message: String) {
        NotificationCenter.default.post(name: .didSendTextAlert, object: nil,
                                        userInfo: [NotificationStrings.didSendTextAlertParameterKey: message])
    }
}
