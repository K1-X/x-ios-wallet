// Copyright DApps Platform Inc. All rights reserved.

import UIKit

protocol WalletManagerControllerDelegate: class {
    func didClickWallet(
        viewModel: WalletAccountViewModel,
        viewController: WalletManagerController
    )
}

