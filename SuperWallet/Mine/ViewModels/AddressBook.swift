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
    
}
