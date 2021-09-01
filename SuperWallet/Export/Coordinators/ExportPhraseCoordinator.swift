// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustKeystore
import TrustCore

final class ExportPhraseCoordinator: RootCoordinator {

    let keystore: Keystore
    let account: Wallet
    let words: [String]
    var coordinators: [Coordinator] = []
    var rootViewController: UIViewController {
        return passphraseViewController
    }
    
}
