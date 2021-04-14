// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustCore
import TrustKeystore
import KeychainSwift

class MultiCoinMigration {
	
	 struct Keys {
        static let watchAddresses = "watchAddresses"
    }

    let keystore: Keystore
    let appTracker: AppTracker
    let keychain = KeychainSwift(keyPrefix: Constants.keychainKeyPrefix)

    // Deprecated
    private var watchAddresses: [String] {
        set {
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            return UserDefaults.standard.set(data, forKey: Keys.watchAddresses)
        }
        get {
            guard let data = UserDefaults.standard.data(forKey: Keys.watchAddresses) else { return [] }
            return NSKeyedUnarchiver.unarchiveObject(with: data) as? [String] ?? []
        }
    }

    init(
        keystore: Keystore,
        appTracker: AppTracker
    ) {
        self.keystore = keystore
        self.appTracker = appTracker
    }

}
