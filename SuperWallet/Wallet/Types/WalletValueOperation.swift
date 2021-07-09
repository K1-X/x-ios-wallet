// Copyright DApps Platform Inc. All rights reserved.

import UIKit

import TrustCore
import BigInt

final class WalletValueOperation: SuperWalletOperation {
    private var balanceProvider: WalletBalanceProvider
    private let keystore: Keystore
    private let wallet: WalletObject

    init(
        balanceProvider: WalletBalanceProvider,
        keystore: Keystore,
        wallet: WalletObject
        ) {
        self.balanceProvider = balanceProvider
        self.keystore = keystore
        self.wallet = wallet
    }    
}
