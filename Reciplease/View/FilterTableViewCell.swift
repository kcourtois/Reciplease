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
        if let filter = filter {
            filter.active = !filter.active
        }
    }

    func configure(filter: HealthFilter) {
        self.filter = filter
        titleLabel.text = filter.title
        descriptionLabel.text = filter.description
        cellSwitch.isOn = filter.active
    }
}
