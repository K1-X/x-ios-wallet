// Copyright DApps Platform Inc. All rights reserved.

import Foundation

final class PreferencesController {

    let userDefaults: UserDefaults

    init(
        userDefaults: UserDefaults = .standard
    ) {
        self.userDefaults = userDefaults
    }


     func set(value: Bool, for option: PreferenceOption) {
        userDefaults.set(value, forKey: option.key)
    }    
}
