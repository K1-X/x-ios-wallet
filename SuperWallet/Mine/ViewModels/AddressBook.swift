import UIKit
import Realm
import RealmSwift

class AddressBook: Object {

    @objc dynamic var headImageURL: String = ""
    @objc dynamic var addressName: String = ""
    @objc dynamic var address: String = ""
    @objc dynamic var remark: String = ""

    convenience init(
        headImageURL: String = "",
        addressName: String = "",
        address: String = "",
        remark: String = ""
        ) {
        self.init()
        self.headImageURL = headImageURL
        self.addressName = addressName
        self.address = address
        self.remark = remark
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
      

}
