// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import TrustKeystore

protocol WalletsViewControllerDelegate: class {
    func didSelect(wallet: WalletInfo, account: Account, in controller: WalletsViewController)
    func didDeleteAccount(account: WalletInfo, in viewController: WalletsViewController)
    func didSelectForInfo(wallet: WalletInfo, account: Account, in controller: WalletsViewController)
}

class WalletsViewController: UITableViewController {

    let keystore: Keystore
    lazy var viewModel: WalletsViewModel = {
        let model = WalletsViewModel(keystore: keystore)
        model.delegate = self
        return model
    }()
    weak var delegate: WalletsViewControllerDelegate?

    init(keystore: Keystore) {
        self.keystore = keystore
        super.init(style: .grouped)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = StyleLayout.TableView.separatorColor
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(resource: R.nib.walletViewCell), forCellReuseIdentifier: R.nib.walletViewCell.name)
        navigationItem.title = viewModel.title
        tableView.tableFooterView = UIView()
    }

}
