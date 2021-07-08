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

    @objc func deleteWallet() {
        confirm(
            title: NSLocalizedString("accounts.confirm.delete.title", value: "Are you sure you would like to delete this wallet?", comment: ""),
            message: NSLocalizedString("accounts.confirm.delete.message", value: "Make sure you have backup of your wallet.", comment: ""),
            okTitle: R.string.localizable.delete(),
            okStyle: .destructive
        ) { [weak self] result in
            switch result {
            case .success:
                self?.navigationController!.topViewController?.displayLoading(
                    text: NSLocalizedString("", value: "", comment: "")
                )
                self?.delegate?.deleteWallet(account: (self?.viewModel.account)!, completion: { [weak self] result in
                    self?.navigationController!.topViewController?.hideLoading()
                    switch result {
                    case .success:
                        self?.navigationController?.popViewController(animated: true)
                    case .failure:
                        let hud = MBProgressHUD.showAdded(to: (self?.view)!, animated: true)
                        hud.mode = .text
                        hud.label.text = ""
                        hud.hide(animated: true, afterDelay: 1.5)
                    }
                })
            case .failure: break
            }
        }

    }

     @objc func saveWallet() {
        let textInputCell: TextInputCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! TextInputCell
        let walletName = textInputCell.inputTextField.text ?? ""
        delegate?.saveWallet(account: viewModel.account, walletName: walletName)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
