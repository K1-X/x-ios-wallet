// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import RealmSwift

class AddressBookStorage {

    let realm: Realm
    let addressBookKey: String = "address-book-key"

    var addresses: [AddressBook] {
        return Array(realm.objects(AddressBook.self))
    }

    init(realm: Realm) {
        self.realm = realm
    }

    func store(address: [AddressBook]) {
        try? realm.write {
            realm.add(address, update: .all)
        }
    }

    func delete(address: AddressBook) {
        try? realm.write {
            realm.delete(address)
        }
    }
}
