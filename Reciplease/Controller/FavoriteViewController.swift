//
//  FavoriteViewController.swift
//  Reciplease
//
//  Created by Kévin Courtois on 29/05/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var favorites: [FavoriteRecipe] = []
    let storage = RecipeStorageManager()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favorites = storage.fetchAll()
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "segueToFavoriteDetail",
            let recipeDetailVC = segue.destination as? RecipeDetailViewController,
            let recipeIndex = tableView.indexPathForSelectedRow?.row else {
                return
        }

        guard let recipe = Recipe(favorite: favorites[recipeIndex]) else {
            return
        }

        recipeDetailVC.recipe = recipe
    }
}

extension FavoriteViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeCell", for: indexPath)
            as? RecipeTableViewCell else {
                return UITableViewCell()
        }

        guard let recipe = Recipe(favorite: favorites[indexPath.row]) else {
            return UITableViewCell()
        }

        cell.configure(recipe: recipe)

        return cell
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "segueToFavoriteDetail", sender: self)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
