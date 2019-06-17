//
//  ViewController.swift
//  Reciplease
//
//  Created by Kévin Courtois on 23/05/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class IngredientViewController: UIViewController {

    private let preferences = Preferences(defaults: .standard)
    private var model: IngredientViewModel?
    private var alert: UIAlertController?

    @IBOutlet weak var filtersLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        model = IngredientViewModel(preferences: preferences)
        if let model = model {
            filtersLabel.text = model.getFilters()
        }
    }

    @IBAction func addIngredient() {
        //If textfield empty, do nothing
        guard let text = textField.text, !text.isEmpty else {
            return
        }

        preferences.ingredients.append("- "+text)
        textField.text = ""
        tableView.reloadData()
    }

    @IBAction func clearIngredients() {
        preferences.ingredients = []
        tableView.reloadData()
    }

    @IBAction func searchRecipes() {
        alert = loadingAlert()
        if let model = model {
            model.searchRecipes()
        } else {
            if let alert = alert {
                alert.dismiss(animated: true) {
                    self.presentAlert(title: "Error", message: "An error occured, please try again.")
                }
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToRecipesList", let recipeListVC = segue.destination as? RecipeListViewController {
            if let model = model {
                recipeListVC.recipes = model.recipes
            } else {
                recipeListVC.recipes = []
            }
        }
    }
}

// MARK: - Notifications
extension IngredientViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(onDidSendTextAlert(_:)),
                                               name: .didSendTextAlert, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidSendPerformSegue(_:)),
                                               name: .didSendPerformSegue, object: nil)
    }

    //Triggers on notification didSendLoadingAlert
    @objc private func onDidSendTextAlert(_ notification: Notification) {
        if let alert = alert {
            alert.dismiss(animated: true) {
                if let data = notification.userInfo as? [String: String] {
                    for (_, message) in data {
                        self.presentAlert(title: "Error", message: message)
                    }
                }
            }
        }
    }

    //Triggers on notification didSendLoadingAlert
    @objc private func onDidSendPerformSegue(_ notification: Notification) {
        guard let alert = alert else {
            self.performSegue(withIdentifier: "segueToRecipesList", sender: nil)
            return
        }
        alert.dismiss(animated: true) {
            self.performSegue(withIdentifier: "segueToRecipesList", sender: nil)
        }
    }
}

// MARK: - Tableview
extension IngredientViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preferences.ingredients.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientCell", for: indexPath)
        let ingredient = preferences.ingredients[indexPath.row]

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
