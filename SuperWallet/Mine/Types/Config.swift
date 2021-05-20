// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustCore

struct Config {
    private struct Keys {
        static let currencyID = "currencyID"
    }
    
    static let dbMigrationSchemaVersion: UInt64 = 5
    static let current: Config = Config()
    let defaults: UserDefaults
    init(
        defaults: UserDefaults = UserDefaults.standard
    ) {
        self.defaults = defaults
    }    
}
