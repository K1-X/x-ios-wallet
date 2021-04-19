// Copyright DApps Platform Inc. All rights reserved.

import BigInt
import Foundation
import Result
import KeychainSwift
import CryptoSwift
import TrustCore
import TrustKeystore

enum EtherKeystoreError: LocalizedError {
    case protectionDisabled
}

class EtherKeystore: Keystore {

 struct Keys {
        static let recentlyUsedAddress: String = "recentlyUsedAddress"
        static let recentlyUsedWallet: String = "recentlyUsedWallet"
    }

    private let keychain: KeychainSwift
    private let datadir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    let keyStore: KeyStore
    private let defaultKeychainAccess: KeychainSwiftAccessOptions = .accessibleWhenUnlockedThisDeviceOnly
    let keysDirectory: URL
    let userDefaults: UserDefaults
    let storage: WalletStorage

    public init(
        keychain: KeychainSwift = KeychainSwift(keyPrefix: Constants.keychainKeyPrefix),
        keysSubfolder: String = "/keystore",
        userDefaults: UserDefaults = UserDefaults.standard,
        storage: WalletStorage
    ) {
        self.keysDirectory = URL(fileURLWithPath: datadir + keysSubfolder)
        self.keychain = keychain
        self.keychain.synchronizable = false
        self.keyStore = try! KeyStore(keyDirectory: keysDirectory)
        self.userDefaults = userDefaults
        self.storage = storage
    }    

    var hasWallets: Bool {
        return !wallets.isEmpty
    }

    var mainWallet: WalletInfo? {
        return wallets.filter { $0.mainWallet }.first
    }

    var wallets: [WalletInfo] {
        return [
            keyStore.wallets.filter { !$0.accounts.isEmpty }.compactMap {
                switch $0.type {
                case .encryptedKey:
                    let type = WalletType.privateKey($0)
                    return WalletInfo(type: type, info: storage.get(for: type))
                case .hierarchicalDeterministicWallet:
                    let type = WalletType.hd($0)
                    return WalletInfo(type: type, info: storage.get(for: type))
                }
            }.filter { !$0.accounts.isEmpty },
            storage.addresses.compactMap {
                guard let address = $0.address else { return .none }
                let type = WalletType.address($0.coin, address)
                return WalletInfo(type: type, info: storage.get(for: type))
            }
        ].flatMap { $0 }.sorted(by: { $0.info.createdAt < $1.info.createdAt })
    }
}
