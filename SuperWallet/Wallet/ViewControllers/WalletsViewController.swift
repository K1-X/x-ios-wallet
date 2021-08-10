// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import TrustKeystore

protocol WalletsViewControllerDelegate: class {
    func didSelect(wallet: WalletInfo, account: Account, in controller: WalletsViewController)
    func didDeleteAccount(account: WalletInfo, in viewController: WalletsViewController)
    func didSelectForInfo(wallet: WalletInfo, account: Account, in controller: WalletsViewController)
}

