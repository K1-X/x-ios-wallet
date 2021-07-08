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

extension WalletEditController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                let editWalletHeaderCell: EditWalletHeaderCell = tableView.dequeueReusableCell(withIdentifier: R.nib.editWalletHeaderCell.name) as! EditWalletHeaderCell
                editWalletHeaderCell.viewModel = viewModel
                return editWalletHeaderCell
            case 1:
                let textInputCell: TextInputCell = tableView.dequeueReusableCell(withIdentifier: R.nib.textInputCell.name) as! TextInputCell
                textInputCell.setPlaceholder(placeholder: R.string.localizable.walletEditName())
                textInputCell.setText(text: viewModel.title)
                return textInputCell
            case 2:
                let tableViewCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCell")!
                tableViewCell.textLabel?.textColor = .black
                tableViewCell.textLabel?.text = dataList[indexPath.section][indexPath.row]
                tableViewCell.accessoryType = .disclosureIndicator
                tableViewCell.selectionStyle = .none
                return tableViewCell
            default:
                break
            }
        } else {
            let tableViewCell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCell")!
            tableViewCell.textLabel?.textColor = .black
            tableViewCell.textLabel?.text = dataList[indexPath.section][indexPath.row]
            tableViewCell.accessoryType = .disclosureIndicator
            tableViewCell.selectionStyle = .none
            if indexPath.row == 0 {
                let lineView: UIView = UIView()
                lineView.backgroundColor = Colors.veryLightGray
                tableViewCell.addSubview(lineView)
                lineView.snp.makeConstraints { (make) in
                    make.bottom.equalToSuperview()
                    make.leading.trailing.equalToSuperview()
                    make.height.equalTo(1)
                }
            }
            return tableViewCell
        }
        return UITableViewCell()
    }
}

extension WalletEditController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                return 240
            case 1:
                return 60
            case 2:
                return 60
            default:
                break
            }
        } else {
            return 60
        }
        return 0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 20
        }
        return 0.00001
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view: UIView = UIView()
        if section == 0 {
            view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 20)
            view.backgroundColor = Colors.veryLightGray
        }
        return view
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.row == 2 {
            self.changePassword()
        } else if indexPath.section == 1 && indexPath.row == 0 {
            self.exportPrivate()
        } else if indexPath.section == 1 && indexPath.row == 1 {
            self.exportKeyStore()
        }
    }
}

