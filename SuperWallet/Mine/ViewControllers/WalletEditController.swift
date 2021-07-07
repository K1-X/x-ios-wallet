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

class WalletEditController: UIViewController {
    weak var delegate: WalletEditControllerDelegate?
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.backgroundColor = Colors.veryLightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(resource: R.nib.editWalletHeaderCell), forCellReuseIdentifier: R.nib.editWalletHeaderCell.name)
        tableView.register(UINib(resource: R.nib.textInputCell), forCellReuseIdentifier: R.nib.textInputCell.name)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "customTableViewCell")
        return tableView
    }()
    lazy var deleteButton: UIButton = {
        let deleteButton: UIButton = UIButton(type: .custom)
        deleteButton.setBackgroundColor(Colors.lightGray, forState: .normal)
        deleteButton.setTitleColor(Colors.white, for: .normal)
        deleteButton.setTitle(R.string.localizable.walletEditDelete(), for: .normal)
        deleteButton.addTarget(self, action: #selector(deleteWallet), for: .touchUpInside)
        return deleteButton
    }()

    lazy var footerView: UIView = {
        let footerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 98))
        footerView.backgroundColor = Colors.veryLightGray
        footerView.addSubview(deleteButton)
        return footerView
    }()

}
