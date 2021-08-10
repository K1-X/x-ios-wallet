// Copyright DApps Platform Inc. All rights reserved.

import UIKit

class VersionCheck: NSObject, Decodable {

     @objc dynamic var appVersion: Int = 0
    @objc dynamic var isForceUpgrade: String = ""
    @objc dynamic var downloadUrl: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var isNew: String = ""
    @objc dynamic var packageSize: Int = 0
    @objc dynamic var displayVer: String = ""
    @objc dynamic var checksum: String = ""    
}
