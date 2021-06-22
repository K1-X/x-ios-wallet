import Foundation
import RealmSwift

class ChainStorage {

    let realm: Realm
    var blocks: [ChainObject] {
        return Array(realm.objects(ChainObject.self))
    }
   
}
