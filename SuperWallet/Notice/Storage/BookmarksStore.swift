// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import RealmSwift

final class BookmarksStore {

var bookmarks: Results<Bookmark> {
        return realm.objects(Bookmark.self)
            .sorted(byKeyPath: "createdAt", ascending: false)
    }

    let realm: Realm
    init(
        realm: Realm
    ) {
        self.realm = realm
    }  
}
