//
//  NotificationStrings.swift
//  Reciplease
//
//  Created by Kévin Courtois on 11/06/2019.
//  Copyright © 2019 Kévin Courtois. All rights reserved.
//

import Foundation

class NotificationStrings {
    static let didSendTextAlertParameterKey: String = "text"
    static let didSendPerformSegueParameterKey: String = "segue"
}

extension Notification.Name {
    static let didSendTextAlert = Notification.Name("didSendTextAlert")
    static let didSendPerformSegue = Notification.Name("didSendPerformSegue")
}
