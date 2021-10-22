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

    func isPasscodeSet() -> Bool {
        return currentPasscode() != nil
    }

    func currentPasscode() -> String? {
        return SAMKeychain.password(forService: Keys.service, account: Keys.account)
    }    

    func isPasscodeValid(passcode: String) -> Bool {
        return passcode == currentPasscode()
    }

    func setAutoLockType(type: AutoLock) {
         keychain.set(String(type.rawValue), forKey: autoLockType)
    }

    func getAutoLockType() -> AutoLock {
        let id = keychain.get(autoLockType)
        guard let type = id, let intType = Int(type), let autoLock = AutoLock(rawValue: intType) else {
            return .immediate
        }
        return autoLock
    }

    func setAutoLockTime() {
        guard isPasscodeSet(), keychain.get(autoLockTime) == nil else { return }
        let timeString = dateFormatter().string(from: Date())
        keychain.set(timeString, forKey: autoLockTime)
    }

    func getAutoLockTime() -> Date {
        guard let timeString = keychain.get(autoLockTime), let time = dateFormatter().date(from: timeString) else {
            return Date()
        }
        return time
    }

    func setTouchId() {
        keychain.set("touchId", forKey: touchId)
    }

    func getTouchId() -> Bool {
        let touchIdValue = keychain.get(touchId)
        guard let touchIdStr = touchIdValue else {
            return false
        }
        return true
    }

    func setPasscode(passcode: String) {
        SAMKeychain.setPassword(passcode, forService: Keys.service, account: Keys.account)
    }
}
