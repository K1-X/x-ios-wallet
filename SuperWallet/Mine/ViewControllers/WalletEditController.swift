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
    
    let dataList: Array = [[R.string.localizable.walletEditName(), "", R.string.localizable.walletEditChangePassword()], [R.string.localizable.walletEditExportPrivatekey(), R.string.localizable.walletEditExportKeystore()]]

    let viewModel: WalletAccountViewModel
    init(viewModel: WalletAccountViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.white
        title = viewModel.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(saveWallet))
        tableView.tableFooterView = footerView
        view.addSubview(tableView)
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(currentNaviHeight)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        deleteButton.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(edgeWidth)
            make.trailing.equalToSuperview().offset(-edgeWidth)
            make.height.equalTo(48)
        })
    }
}
