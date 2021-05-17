// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import RealmSwift

final class  HistoryStore {
    var histories: Results<History> {
        return realm.objects(History.self)
            .sorted(byKeyPath: "createdAt", ascending: false)
    }

    let realm: Realm

    init(realm: Realm) {
        self.realm = realm
    }

    lazy var ignoreSet: Set<String> = {
        let set = Set<String>([
            Constants.dappsBrowserURL
        ])
        return set
    }()
}

