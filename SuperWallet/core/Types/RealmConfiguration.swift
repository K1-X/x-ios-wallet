// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import RealmSwift
import TrustCore

struct RealmConfiguration {

    static func sharedConfiguration() -> Realm.Configuration {
        var config = Realm.Configuration()
        let directory = config.fileURL!.deletingLastPathComponent()
        let url = directory.appendingPathComponent("shared.realm")
        print("shared.realm:" + url.absoluteString)
        return Realm.Configuration(fileURL: url)
    }

    static func configuration(for account: WalletInfo) -> Realm.Configuration {
        var config = Realm.Configuration()
        let directory = config.fileURL!.deletingLastPathComponent()
        let newURL = directory.appendingPathComponent("\(account.description).realm")
        print("\(account.description).realm:" + newURL.absoluteString)
        config.fileURL = newURL
        return config
    }

    static func addressBookConfiguration() -> Realm.Configuration {
        var config = Realm.Configuration()
        let directory = config.fileURL!.deletingLastPathComponent()
        let url = directory.appendingPathComponent("addressBook.realm")
        return Realm.Configuration(fileURL: url)
    }
}
