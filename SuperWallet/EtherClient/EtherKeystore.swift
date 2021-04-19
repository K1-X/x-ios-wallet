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

   var recentlyUsedWallet: WalletInfo? {
        set {
            keychain.set(newValue?.description ?? "", forKey: Keys.recentlyUsedWallet, withAccess: defaultKeychainAccess)
        }
        get {
            let walletKey = keychain.get(Keys.recentlyUsedWallet)
            let foundWallet = wallets.filter { $0.description == walletKey }.first
            guard let wallet = foundWallet else {
                // Old way to match recently selected address
                let address = keychain.get(Keys.recentlyUsedAddress)
                return wallets.filter {
                    $0.address.description == address || $0.description.lowercased() == address?.lowercased()
                }.first
            }
            return wallet
        }
    }
    
    // Async
    @available(iOS 10.0, *)
    func createAccount(with password: String, completion: @escaping (Result<Wallet, KeystoreError>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let account = self.createAccout(password: password)
            DispatchQueue.main.async {
                completion(.success(account))
            }
        }
    }

    func importWallet(type: ImportType, coin: Coin, completion: @escaping (Result<WalletInfo, KeystoreError>) -> Void) {
        let newPassword = PasswordGenerator.generateRandom()
        switch type {
        case .keystore(let string, let password):
            importKeystore(
                value: string,
                password: password,
                newPassword: newPassword,
                coin: coin
            ) { result in
                switch result {
                case .success(let account):
                    let type = WalletType.privateKey(account)
                    completion(.success(WalletInfo(type: type, info: self.storage.get(for: type))))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        case .privateKey(let privateKey, let password):
            let hexStringData: Data = Data(hex: privateKey)
            let privateKeyData = PrivateKey(data:hexStringData)!
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let wallet = try self.keyStore.import(privateKey: privateKeyData, password: password, coin: coin)
                    self.setPassword(newPassword, for: wallet)
                    DispatchQueue.main.async {
                        completion(.success(WalletInfo(type: .privateKey(wallet))))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(KeystoreError.failedToImportPrivateKey))
                    }
                }
            }
        case .mnemonic(let words, let passphrase, let derivationPath):
            let string = words.map { try! String($0) }.joined(separator: " ")
            if !Crypto.isValid(mnemonic: string) {
                return completion(.failure(KeystoreError.invalidMnemonicPhrase))
            }
            do {
                let account = try keyStore.import(mnemonic: string, passphrase: passphrase, encryptPassword: newPassword, derivationPath: derivationPath)
                setPassword(newPassword, for: account)
                completion(.success(WalletInfo(type: .hd(account))))
            } catch {
                return completion(.failure(KeystoreError.duplicateAccount))
            }
        case .address(let address):
            let watchAddress = WalletAddress(coin: coin, address: address)
            guard !storage.addresses.contains(watchAddress) else {
                return completion(.failure(.duplicateAccount))
            }
            storage.store(address: [watchAddress])
            let type = WalletType.address(coin, address)
            completion(.success(WalletInfo(type: type, info: storage.get(for: type))))
        }
    }
    
    func importKeystore(value: String, password: String, newPassword: String, coin: Coin, completion: @escaping (Result<Wallet, KeystoreError>) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let result = self.importKeystore(value: value, password: password, newPassword: newPassword, coin: coin)
            DispatchQueue.main.async {
                switch result {
                case .success(let account):
                    completion(.success(account))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
    
    func createAccout(password: String) -> Wallet {
        let wallet  = try! keyStore.createWallet(password: password, for: Coin(rawValue: 60)!)
        let _ = setPassword(password, for: wallet)
        return wallet
    }

    func importPrivateKey(privateKey: PrivateKey, password: String, coin: Coin) -> Result<WalletInfo, KeystoreError> {
        do {
            let wallet = try keyStore.import(privateKey: privateKey, password: password, coin: coin)
            let w = WalletInfo(type: .privateKey(wallet))
            let _ = setPassword(password, for: wallet)
            return .success(w)
        } catch {
            return .failure(.failedToImport(error))
        }
    }


}


