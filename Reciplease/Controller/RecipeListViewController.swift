//
//  RecipeListViewController.swift
//  Reciplease
//
//  Created by Kévin Courtois on 23/05/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class RecipeListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var recipes: [Recipe] = []
    var showFavoritesList: Bool = true

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if showFavoritesList {
            fillFavoriteRecipesList()
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "segueToRecipeDetail",
            let recipeDetailVC = segue.destination as? RecipeDetailViewController,
            let recipeIndex = tableView.indexPathForSelectedRow?.row else {
                return
        }
        recipeDetailVC.recipe = recipes[recipeIndex]
    }

    func fillFavoriteRecipesList() {
        let storage = RecipeStorageManager()

        for favorite in storage.fetchAll() {
            guard let name = favorite.name,
                let imgData = favorite.image,
                let ingredients = favorite.ingredients,
                let source = favorite.source else {
                    return
            }

            guard let image = UIImage(data: imgData) else {
                return
            }

            recipes.append(Recipe(name: name, image: image, time: Int(favorite.time),
                                  servings: Int(favorite.servings), ingredients: ingredients,
                                  source: source, favorite: false))
        }
    }
}

extension RecipeListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
            as? RecipeTableViewCell else {
                return UITableViewCell()
        }

        let recipe = recipes[indexPath.row]
        cell.configure(recipe: recipe)

        return cell
    }
}

extension RecipeListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToRecipeDetail", sender: self)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
