// Copyright DApps Platform Inc. All rights reserved.

import UIKit

protocol WalletManagerControllerDelegate: class {
    func didClickWallet(
        viewModel: WalletAccountViewModel,
        viewController: WalletManagerController
    )
}

class WalletManagerController: UITableViewController {

    let keystore: Keystore
    lazy var viewModel: WalletsViewModel = {
        let model = WalletsViewModel(keystore: keystore)
        model.delegate = self
        return model
    }()

    weak var delegate: WalletManagerControllerDelegate?

    init(keystore: Keystore) {
        self.keystore = keystore
        super.init(style: .grouped)
    }

}

