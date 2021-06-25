// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import RealmSwift

class WalletStorage {

    let realm: Realm

    var addresses: [WalletAddress] {
        return Array(realm.objects(WalletAddress.self))
    }
    
}
