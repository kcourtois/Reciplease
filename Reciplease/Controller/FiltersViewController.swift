//
//  FiltersViewController.swift
//  Reciplease
//
//  Created by Kévin Courtois on 05/06/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class FiltersViewController: UIViewController {

    private let filters = HealthFilter.getList()
    var tags: [String] = []

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        activeTags()
    }

    @IBAction func dismissFilters(_ sender: Any) {
        //Get tab bar reference
        if let tabBar = presentingViewController as? UITabBarController {
            //Get navigationController reference
            if let navigation = tabBar.selectedViewController as? UINavigationController {
                //Get ingredientViewController reference
                if let ingredientVC = navigation.topViewController as? IngredientViewController {
                    tags = []
                    for filter in filters where filter.active {
                        tags.append(filter.tag)
                    }
                    //Give filter tags to ingredientViewController
                    ingredientVC.tags = tags
                }
            }
        }
        dismiss(animated: true, completion: nil)
    }

    //Set filters active if tag is in the list
    func activeTags() {
        for tag in tags {
            for filter in filters where filter.tag == tag {
                filter.active = true
            }
        }
    }
}

// MARK: - Tableview
extension FiltersViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filters.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath)
            as? FilterTableViewCell else {
                return UITableViewCell()
        }

        let filter = filters[indexPath.row]
        cell.configure(filter: filter)

        return cell
    }
}
