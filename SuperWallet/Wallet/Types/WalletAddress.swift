// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import RealmSwift
import TrustCore

final class WalletAddress: Object {

    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var addressString: String = ""
    @objc private dynamic var rawCoin = -1
    public var coin: Coin {
        get { return Coin(rawValue: rawCoin) ?? .ethereum }
        set { rawCoin = newValue.rawValue }
    }    
}
