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

    var currency: Currency {
        get {
            if let currency = defaults.string(forKey: Keys.currencyID) {
                return Currency(rawValue: currency)!
            }
            let avaliableCurrency = Currency.allValues.first { currency in
                return currency.rawValue == Locale.current.currencySymbol
            }
            if let isAvaliableCurrency = avaliableCurrency {
                return isAvaliableCurrency
            }
            return Currency.CNY
        }
        set { defaults.set(newValue.rawValue, forKey: Keys.currencyID) }
    }

}
