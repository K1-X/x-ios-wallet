// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import Eureka
import TrustKeystore

protocol WalletInfoViewControllerDelegate: class {
    func didPress(item: WalletInfoType, in controller: WalletInfoViewController)
    func didPressSave(wallet: WalletInfo, fields: [WalletInfoField], in controller: WalletInfoViewController)
}

enum WalletInfoField {
    case name(String)
    case backup(Bool)
    case mainWallet(Bool)
    case balance(String)
}

