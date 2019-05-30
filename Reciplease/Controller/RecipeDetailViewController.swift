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

    var recipe: Recipe = Recipe(name: "Erreur", image: UIImage(), time: 0, servings: 0,
                                ingredients: [], source: "", favorite: false)

    override func viewDidLoad() {
        super.viewDidLoad()
        setBarButton()
        setRecipeView()
    }

    @IBAction func getDirections() {
        if let url = URL(string: recipe.source) {
            let svc = SFSafariViewController(url: url)
            present(svc, animated: true, completion: nil)
        }
    }

    @objc func favoriteTapped() {
        recipe.favorite = !recipe.favorite
        setBarButton()
    }

    private func setRecipeView() {
        recipeResume.imageView.image = recipe.image
        recipeResume.title.text = recipe.name.capitalized
        recipeResume.servings.text = "\(recipe.servings)"
        recipeResume.time.text = "\(recipe.time) m"
        recipeResume.subtitle.text = ""
    }

    private func setBarButton() {
        var image = UIImage()

        if recipe.favorite {
            image = #imageLiteral(resourceName: "greenstar")
        } else {
            image = #imageLiteral(resourceName: "whitestar")
        }

        //create a new button
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(favoriteTapped), for: .touchUpInside)
        let barButton = UIBarButtonItem(customView: button)
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = barButton
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
