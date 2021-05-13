// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import WebKit
import PromiseKit
import KeychainSwift

enum CookiesStoreError: LocalizedError {
    case empty
}

final class CookiesStore {

    private static let webKitStorage = WKWebsiteDataStore.default()
    private static let httpCookieStorage = HTTPCookieStorage.shared
    private static let keychain = KeychainSwift(keyPrefix: Constants.keychainKeyPrefix)


    private static let cookiesKey = "cookies"

    static func save() {
        firstly {
            fetchCookies()
        }.done { cookies in
            save(cookies: cookies)
        }.catch { _ in }
    }
}
