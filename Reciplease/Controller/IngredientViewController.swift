//
//  ViewController.swift
//  Reciplease
//
//  Created by Kévin Courtois on 23/05/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class IngredientViewController: UIViewController {

    private var recipes: [Recipe] = []

    @IBOutlet weak var filtersLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if Preferences.filters.isEmpty {
            filtersLabel.text = "Filters: None"
        } else {
            var text = "Filters: "
            for (index, tag) in Preferences.filters.enumerated() {
                if index == Preferences.filters.count-1 {
                    text += tag+"."
                } else {
                    text += tag+", "
                }
            }
            filtersLabel.text = text
        }
    }

    @IBAction func addIngredient() {
        //If textfield empty, do nothing
        guard let text = textField.text, !text.isEmpty else {
            return
        }
        //Else add ingredient to the list
        Preferences.ingredients.append("- "+text)
        textField.text = ""
        tableView.reloadData()
    }

    @IBAction func clearIngredients() {
        Preferences.ingredients = []
        tableView.reloadData()
    }

    @IBAction func searchRecipes() {
        //shows a loading alert
        let alert = loadingAlert()

        var search = ""
        for ingredient in Preferences.ingredients {
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
                    self.presentAlert(title: "Error", message: "Couldn't handle your request. Try again later.")
                    return
                }

                self.recipes = res
                self.performSegue(withIdentifier: "segueToRecipesList", sender: nil)
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecipesList", let recipeListVC = segue.destination as? RecipeListViewController {
            recipeListVC.recipes = recipes
        }
    }
}

// MARK: - Tableview
extension IngredientViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Preferences.ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        let ingredient = Preferences.ingredients[indexPath.row]

        cell.textLabel?.text = ingredient

        return cell
    }
}

// MARK: - Keyboard
extension IngredientViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        addIngredient()
        return true
    }
}
