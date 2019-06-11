//
//  FilterTableViewCell.swift
//  Reciplease
//
//  Created by Kévin Courtois on 05/06/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellSwitch: UISwitch!

    private var filter: HealthFilter?

    @IBAction func toggleSwitch() {
        if let index = getFilterIndex() {
            Preferences.filters.remove(at: index)
        } else {
            if let filter = filter {
                Preferences.filters.append(filter.tag)
            }
        }
    }

    func configure(filter: HealthFilter) {
        self.filter = filter
        titleLabel.text = filter.title
        descriptionLabel.text = filter.description
        if getFilterIndex() != nil {
            cellSwitch.isOn = true
        } else {
            cellSwitch.isOn = false
        }
    }

    private func getFilterIndex() -> Int? {
        if let healthFilter = filter {
            for (index, tag) in Preferences.filters.enumerated() where tag == healthFilter.tag {
                return index
            }
        }
        return nil
    }
}
