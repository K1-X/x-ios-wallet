// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import RealmSwift

class RPCStore {

    var endpoints: Results<CustomRPC> {
        return realm.objects(CustomRPC.self)
    }

    let realm: Realm
    init(
        realm: Realm
    ) {
        self.realm = realm
    }
}
