//
//  FiltersViewModel.swift
//  Reciplease
//
//  Created by Kévin Courtois on 12/06/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import Foundation
import UIKit

struct FiltersViewModel {
    let filter: HealthFilter
    var active: Bool {
        return getFilterIndex() != nil
    }

    func toggleSwitch() {
        let pref = Preferences(defaults: .standard)
        if let index = getFilterIndex() {
            pref.filters.remove(at: index)
        } else {
            pref.filters.append(filter.tag)
        }
    }

    private func getFilterIndex() -> Int? {
        let pref = Preferences(defaults: .standard)
        for (index, tag) in pref.filters.enumerated() where tag == filter.tag {
            return index
        }
        return nil
    }
}
