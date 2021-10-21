// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import SAMKeychain
import KeychainSwift

protocol LockInterface {
    func isPasscodeSet() -> Bool
    func shouldShowProtection() -> Bool
}

final class Lock: LockInterface {

    
}
