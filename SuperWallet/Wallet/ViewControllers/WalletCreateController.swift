// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import SnapKit

protocol WalletCreateControllerDelegate: class {
    func didPressCreateWallet(walletName: String, password: String, in viewController: WalletCreateController)
    func didPressImportWallet(in viewController: WalletCreateController)
}

final class WalletCreateController: UIViewController {

    let keystore: Keystore
    weak var delegate: WalletCreateControllerDelegate?
    var dataArray = ["", "", ""]

    var walletName: String?
    var password: String?
    var subPassword: String?

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Colors.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(resource: R.nib.textInputCell), forCellReuseIdentifier: R.nib.textInputCell.name)
        return tableView
    }()

}
