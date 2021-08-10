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
 
     convenience init(
        appVersion: Int,
        isForceUpgrade: String,
        downloadUrl: String,
        desc: String,
        isNew: String,
        packageSize: Int,
        displayVer: String,
        checksum: String
        ) {
        self.init()
        self.appVersion = appVersion
        self.isForceUpgrade = isForceUpgrade
        self.downloadUrl = downloadUrl
        self.desc = desc
        self.isNew = isNew
        self.packageSize = packageSize
        self.displayVer = displayVer
        self.checksum = checksum
    }

    private enum VersionCheckCodingKeys: String, CodingKey {
        case appVersion
        case isForceUpgrade
        case downloadUrl
        case description
        case isNew
        case packageSize
        case displayVer
        case checksum
    }
}
