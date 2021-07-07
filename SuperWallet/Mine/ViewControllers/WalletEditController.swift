// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import SnapKit
import MBProgressHUD
import TrustKeystore
import TrustCore
import Result

enum AlertType {
    case exportPrivate
    case exportKeyStore
}

protocol WalletEditControllerDelegate: class {
    func saveWallet(account: Account, walletName: String)
    func changePassword(viewModel: WalletAccountViewModel)
    func exportPrivateKey(account: Account, completion: @escaping (Result<Data, KeystoreError>) -> Void)
    func exportKeystore(account: Account, password: String, completion: @escaping (Result<String, KeystoreError>) -> Void)
    func deleteWallet(account: Account, completion: @escaping (Result<Void, KeystoreError>) -> Void)
}

