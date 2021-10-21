// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import SAMKeychain
import KeychainSwift

protocol LockInterface {
    func isPasscodeSet() -> Bool
    func shouldShowProtection() -> Bool
}

final class Lock: LockInterface {

    private struct Keys {
        static let service = "superwallet.lock"
        static let account = "superwallet.account"
    }

    private let passcodeAttempts = "passcodeAttempts"
    private let maxAttemptTime = "maxAttemptTime"
    private let autoLockType = "autoLockType"
    private let autoLockTime = "autoLockTime"
    private let touchId = "superwallet.touchId"

    private let keychain: KeychainSwift

    init(keychain: KeychainSwift = KeychainSwift(keyPrefix: Constants.keychainKeyPrefix)) {
        self.keychain = keychain
    }

    func shouldShowProtection() -> Bool {
        return isPasscodeSet() && autoLockTriggered()
    }
    
}
