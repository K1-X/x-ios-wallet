import Foundation
import RealmSwift

class ChainStorage {

    let realm: Realm
    var blocks: [ChainObject] {
        return Array(realm.objects(ChainObject.self))
    }

    init(realm: Realm) {
        self.realm = realm
    }   

    func getDefaultBlock() -> ChainObject {
        let chainObjects = realm.objects(ChainObject.self)
        for chainObject in chainObjects {
            if chainObject.chainId == "SCT_LB" {
                return chainObject
            }
        }
        return realm.objects(ChainObject.self).first!
    }
}
