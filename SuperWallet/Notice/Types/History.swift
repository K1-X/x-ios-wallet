// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import RealmSwift

final class History: Object {
    @objc dynamic var url: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var createdAt: Date = Date()
    @objc dynamic var id: String = ""
}
