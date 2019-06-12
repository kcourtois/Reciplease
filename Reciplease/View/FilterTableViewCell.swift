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

    var filterViewModel: FiltersViewModel? {
        didSet {
            if let fvm = filterViewModel {
                titleLabel.text = fvm.filter.title
                descriptionLabel.text = fvm.filter.description
                cellSwitch.isOn = fvm.active
            }
        }
    }

    @IBAction func toggleSwitch() {
        if let fvm = filterViewModel {
            fvm.toggleSwitch()
            cellSwitch.isOn = fvm.active
        }
    }
}
