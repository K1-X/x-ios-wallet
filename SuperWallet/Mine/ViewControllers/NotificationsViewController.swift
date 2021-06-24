// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import Eureka

struct NotificationChange: Codable {
    let isEnabled: Bool
    let preferences: Preferences
}

enum NotificationChanged {
    case state(isEnabled: Bool)
    case preferences(Preferences)
}


final class NotificationsViewController: FormViewController {

    private let viewModel = NotificationsViewModel()
    private let preferencesController: PreferencesController

    private struct Keys {
        static let pushNotifications = "pushNotifications"
        static let payment = "payment"
    }

    var didChange: ((_ change: NotificationChanged) -> Void)?

    private static var isPushNotificationEnabled: Bool {
        guard let settings = UIApplication.shared.currentUserNotificationSettings else { return false }
        return UIApplication.shared.isRegisteredForRemoteNotifications && !settings.types.isEmpty
    }

    private var showOptionsCondition: Condition {
        return Condition.predicate(NSPredicate(format: "$\(Keys.pushNotifications) == false"))
    }

}
