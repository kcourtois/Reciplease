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

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dismissFilters(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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

        cell.filterViewModel = FiltersViewModel(filter: filters[indexPath.row],
                                                preferences: Preferences(defaults: .standard))

        return cell
    }
}
