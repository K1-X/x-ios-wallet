// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import SnapKit

protocol WalletCreateControllerDelegate: class {
    func didPressCreateWallet(walletName: String, password: String, in viewController: WalletCreateController)
    func didPressImportWallet(in viewController: WalletCreateController)
}

