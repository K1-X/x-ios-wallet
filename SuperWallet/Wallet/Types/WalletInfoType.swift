// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustKeystore
import UIKit
import TrustCore

enum WalletInfoType {

    case exportRecoveryPhrase(Wallet)
    case exportPrivateKey(Account)
    case exportKeystore(Account)
    case copyAddress(Address)    
}
