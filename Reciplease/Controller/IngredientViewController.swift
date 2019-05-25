//
//  ViewController.swift
//  Reciplease
//
//  Created by Kévin Courtois on 23/05/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class IngredientViewController: UIViewController {

    var ingredients: [String] = []

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addIngredient() {
        if let text = textField.text {
            ingredients.append("- "+text)
            textField.text = ""
            tableView.reloadData()
        }
    }

    @IBAction func clearIngredients() {
        ingredients = []
        tableView.reloadData()
    }

    @IBAction func searchRecipes() {
        let rserv = RecipeService()
        var search = ""
        for ingredient in ingredients {
            let index = ingredient.index(ingredient.endIndex, offsetBy: -ingredient.count+2)
            let substring = ingredient[index...] // playground
            search += "+" + String(substring)
        }

        rserv.search(searchText: search) { (_, _) in
            //
        }
    }
}

extension IngredientViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        let ingredient = ingredients[indexPath.row]

        cell.textLabel?.text = ingredient

        return cell
    }

}
