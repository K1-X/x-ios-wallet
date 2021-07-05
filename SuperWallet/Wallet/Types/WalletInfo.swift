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

    var currentAccount: Account! {
        switch type {
        case .privateKey, .hd:
            return accounts.first //.filter { $0.description == info.selectedAccount }.first ?? accounts.first!
        case .address(let coin, let address):
            return Account(wallet: .none, address: address, derivationPath: coin.derivationPath(at: 0))
        }
    }

    var currentWallet: Wallet? {
        switch type {
        case .privateKey(let wallet), .hd(let wallet):
            return wallet
        case .address:
            return .none
        }
    }

    var isWatch: Bool {
        switch type {
        case .privateKey, .hd:
            return false
        case .address:
            return true
        }
    }

    var title: String {
        if multiWallet {
            return info.name
        }
        if !info.name.isEmpty {
            return  info.name + " (" + coin!.server.symbol + ")"
        }
        return WalletInfo.emptyName
    }

    var balance: String {
        guard !info.balance.isEmpty, let server = coin?.server else {
            return  WalletInfo.format(value: "0.0", server: .main)
        }
        return WalletInfo.format(value: shortFormatter.string(from: BigInt(info.balance) ?? BigInt(), decimals: server.decimals), server: server)
    }
    var image: UIImage? {
        guard let coin = coin else { return .none }
        if multiWallet {
            return R.image.superwallet_icon()
        }
        return CoinViewModel(coin: coin).image
    }

    init(
        type: WalletType,
        info: WalletObject? = .none
    ) {
        self.type = type
        self.info = info ?? WalletObject.from(type)
    }

    var description: String {
        return type.description
    }
}
