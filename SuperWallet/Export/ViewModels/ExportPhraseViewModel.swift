// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustKeystore

struct ExportPhraseViewModel {

    let keystore: Keystore
    let account: Wallet

    init(
        keystore: Keystore,
        account: Wallet
    ) {
        self.keystore = keystore
        self.account = account
    }
    
}
