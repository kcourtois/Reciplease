//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Kévin Courtois on 23/05/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit
import SafariServices

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var recipeResume: RecipeResume!

    var recipe: Recipe = Recipe(name: "Erreur", image: UIImage(), time: 0, servings: 0, ingredients: [], source: "")

    override func viewDidLoad() {
        super.viewDidLoad()
        let favorite = UIBarButtonItem(image: #imageLiteral(resourceName: "whitestar"), style: .plain, target: self, action: #selector(favoriteTapped))
        navigationItem.rightBarButtonItem = favorite

        setRecipeView()
    }

    @IBAction func getDirections() {
        if let url = URL(string: recipe.source) {
            let svc = SFSafariViewController(url: url)
            present(svc, animated: true, completion: nil)
        }
    }

    @objc func favoriteTapped() {
        print("tap")
        //add favorite
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "greenstar"), style: .plain,
                                                                 target: self, action: #selector(favoriteTapped))
    }

    private func setRecipeView() {
        recipeResume.imageView.image = recipe.image
        recipeResume.title.text = recipe.name.capitalized
        recipeResume.servings.text = "\(recipe.servings)"
        recipeResume.time.text = "\(recipe.time) m"
        recipeResume.subtitle.text = ""
    }
}

extension RecipeDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipe.ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        let ingredient = recipe.ingredients[indexPath.row]

        cell.textLabel?.text = "- " + ingredient

        return cell
    }

}
