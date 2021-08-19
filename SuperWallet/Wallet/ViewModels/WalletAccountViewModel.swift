// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit
import TrustKeystore
import TrustCore
import BigInt

struct WalletAccountViewModel {

    let keystore: Keystore
    let wallet: WalletInfo
    let account: Account
    let currentWallet: WalletInfo?
    private let shortFormatter = EtherNumberFormatter.short

    var title: String {
        if wallet.multiWallet {
            return wallet.info.name
        }
        if !wallet.info.name.isEmpty {
            return  wallet.info.name + " (" + wallet.coin!.server.symbol + ")"
        }
        return WalletInfo.emptyName
    }

    var isBalanceHidden: Bool {
        return wallet.multiWallet
    }    
}
