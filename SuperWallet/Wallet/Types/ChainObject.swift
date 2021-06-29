// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import RealmSwift
import Realm
import TrustCore

class ChainObject: Object, Decodable {
    @objc dynamic var name: String = ""
    @objc dynamic var chainId: String = ""
    @objc dynamic var explorUrl: String = ""
    @objc dynamic var pkId: Int = 1

    convenience init(
        name: String = "",
        chainId: String = "",
        explorUrl: String = "",
        pkId: Int = 1
        ) {
        self.init()
        self.name = name
        self.chainId = chainId
        self.explorUrl = explorUrl
        self.pkId = pkId
    }

    required init() {
        super.init()
    }

    required init(value: Any, schema: RLMSchema) {
        super.init(value: value, schema: schema)
    }

    required init(realm: RLMRealm, schema: RLMObjectSchema) {
        super.init(realm: realm, schema: schema)
    }

    override static func primaryKey() -> String? {
        return "chainId"
    }
}
