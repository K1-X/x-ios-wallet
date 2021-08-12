// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustCore

struct CoinViewModel {

    let coin: Coin

    var displayName: String {
        return "\(name) (\(symbol))"
    }

    
}
