// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustKeystore
import TrustCore
import BigInt

struct WalletInfo {

    let type: WalletType
    let info: WalletObject
    private let shortFormatter = EtherNumberFormatter.short

    var address: Address {
        switch type {
        case .privateKey, .hd:
            return currentAccount.address
        case .address(_, let address):
            return address
        }
    }    

    var coin: Coin? {
        switch type {
        case .privateKey, .hd:
            guard let account = currentAccount,
                let coin = Coin(rawValue: account.derivationPath.coinType) else {
                    return .none
            }
            return coin
        case .address(let coin, _):
            return coin
        }
    }

    var multiWallet: Bool {
        return accounts.count > 1
    }

    var mainWallet: Bool {
        return info.mainWallet
    }

    var accounts: [Account] {
        switch type {
        case .privateKey(let account), .hd(let account):
            return account.accounts
        case .address(let coin, let address):
            return [
                Account(wallet: .none, address: address, derivationPath: coin.derivationPath(at: 0))
            ]
        }
    }
}
