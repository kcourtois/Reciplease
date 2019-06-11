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

    var recipe: Recipe = Recipe(name: "Error", image: UIImage(), time: 0, servings: 0,
                                ingredients: [], source: "")
    private var favorite: FavoriteRecipe?

    override func viewDidLoad() {
        super.viewDidLoad()
        setRecipeView()
    }

    override func viewWillAppear(_ animated: Bool) {
        let storage = RecipeStorageManager()
        //Retrieve favorite recipe if exists
        favorite = storage.fetchFavorite(recipe: recipe)
        setBarButton()
    }

    @IBAction func getDirections() {
        if let url = URL(string: recipe.source) {
            let svc = SFSafariViewController(url: url)
            present(svc, animated: true, completion: nil)
        }
    }

    @objc func favoriteTapped() {
        handleFavoriteStorage()
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

        if favorite != nil {
            image = #imageLiteral(resourceName: "greenstar")
        } else {
            image = #imageLiteral(resourceName: "whitestar")
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem.menuButton(self, action: #selector(favoriteTapped),
                                                                       image: image)
    }

    private func handleFavoriteStorage() {
        let storage = RecipeStorageManager()
        if favorite == nil {
            favorite = storage.insertFavorite(recipe: recipe)
            storage.save()
            presentAlertDelay(title: "Added favorite", message: "Successfully added recipe to favorites", delay: 1)
        } else {
            guard let fav = favorite else {
                return
            }
            storage.remove(objectID: fav.objectID)
            storage.save()
            favorite = nil
            presentAlertDelay(title: "Removed favorite",
                              message: "Successfully removed recipe from favorites", delay: 1)
        }
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

extension UIBarButtonItem {
    static func menuButton(_ target: Any?, action: Selector, image: UIImage) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.setImage(image, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)

        let menuBarItem = UIBarButtonItem(customView: button)
        menuBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24).isActive = true
        menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24).isActive = true

        return menuBarItem
    }
}
