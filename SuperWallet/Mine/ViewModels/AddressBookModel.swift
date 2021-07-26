// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import RealmSwift

struct AddressBookModel {

    let realm: Realm

    lazy var addressBookStorage: AddressBookStorage = {
        return AddressBookStorage(
            realm: realm
        )
    }()

    init(sharedRealm: Realm) {
        self.realm = sharedRealm
    }
}
