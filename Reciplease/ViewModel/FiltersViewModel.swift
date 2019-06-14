//
//  FiltersViewModel.swift
//  Reciplease
//
//  Created by Kévin Courtois on 12/06/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import Foundation

struct FiltersViewModel {
    private let preferences: Preferences
    let filter: HealthFilter
    var active: Bool {
        return getFilterIndex() != nil
    }

    init(filter: HealthFilter, preferences: Preferences) {
        self.filter = filter
        self.preferences = preferences
    }

    func toggleSwitch() {
        if let index = getFilterIndex() {
            preferences.filters.remove(at: index)
        } else {
            preferences.filters.append(filter.tag)
        }
    }

    private func getFilterIndex() -> Int? {
        for (index, tag) in preferences.filters.enumerated() where tag == filter.tag {
            return index
        }
        return nil
    }
}
