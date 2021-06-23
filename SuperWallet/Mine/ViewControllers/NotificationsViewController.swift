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
