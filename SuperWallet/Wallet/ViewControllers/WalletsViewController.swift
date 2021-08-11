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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetch()
    }

    func fetch() {
        viewModel.fetchBalances()
        viewModel.refresh()
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.walletViewCell.name, for: indexPath) as! WalletViewCell
        cell.viewModel = viewModel.cellViewModel(for: indexPath)
        cell.delegate = self
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }
   
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return viewModel.canEditRowAt(for: indexPath)
    }
}
