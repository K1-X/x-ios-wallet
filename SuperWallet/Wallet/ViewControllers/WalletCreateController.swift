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

    lazy var headerView: UIView = {
        let headerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 120))
        headerView.backgroundColor = Colors.blue
        let noticeLabel: UILabel = UILabel()
        noticeLabel.numberOfLines = 0
        noticeLabel.textColor = Colors.white
        noticeLabel.font = UIFont.systemFont(ofSize: 15)
        noticeLabel.text = "*，\n*，f，"
        headerView.addSubview(noticeLabel)
        noticeLabel.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(edgeWidth)
            make.leading.equalToSuperview().offset(edgeWidth)
            make.trailing.equalToSuperview().offset(-edgeWidth)
            make.bottom.equalTo(-edgeWidth)
        })
        return headerView
    }()

    lazy var footerView: UIView = {
        let footerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 156))
        footerView.backgroundColor = Colors.white
        let createWalletButton: UIButton = UIButton(type: .custom)
        createWalletButton.setBackgroundColor(Colors.blue, forState: .normal)
        createWalletButton.layer.cornerRadius = createWalletButton.frame.size.height/2.0
        createWalletButton.layer.masksToBounds = true
        createWalletButton.setTitleColor(Colors.white, for: .normal)
        createWalletButton.setTitle("", for: .normal)
        createWalletButton.addTarget(self, action: #selector(createWallet), for: .touchUpInside)
        footerView.addSubview(createWalletButton)
        createWalletButton.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(edgeWidth)
            make.trailing.equalToSuperview().offset(-edgeWidth)
            make.height.equalTo(48)
        })

        let importWalletButton: UIButton = UIButton(type: .custom)
        importWalletButton.setBackgroundColor(Colors.white, forState: .normal)
        importWalletButton.setTitleColor(Colors.gray, for: .normal)
        importWalletButton.setTitle("，", for: .normal)
        importWalletButton.addTarget(self, action: #selector(importWallet), for: .touchUpInside)
        footerView.addSubview(importWalletButton)
        importWalletButton.snp.makeConstraints({ (make) in
            make.top.equalTo(createWalletButton.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(edgeWidth)
            make.trailing.equalToSuperview().offset(-edgeWidth)
            make.height.equalTo(48)
        })
        return footerView
    }()

    init(
        keystore: Keystore
        ) {
        self.keystore = keystore
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        navigationItem.title = ""
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.separatorStyle = .none
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
        tableView.layoutIfNeeded()
    }

    @objc func createWallet() {
        if password != subPassword {
            return
        }
        guard let password = password, let walletName = walletName else {
            return
        }
        delegate?.didPressCreateWallet(walletName: walletName, password: password, in: self)
    }

    @objc func importWallet() {
        delegate?.didPressImportWallet(in: self)
    }
}

extension WalletCreateController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let textInputCell: TextInputCell = tableView.dequeueReusableCell(withIdentifier: R.nib.textInputCell.name) as! TextInputCell
        if indexPath.row != 0 {
            textInputCell.inputTextField.isSecureTextEntry = true
        } else {
            textInputCell.inputTextField.isSecureTextEntry = false
        }
        textInputCell.setPlaceholder(placeholder: dataArray[indexPath.row])
        textInputCell.delegate = self
        return textInputCell
    }
}

extension WalletCreateController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension WalletCreateController: TextInputCellDelegate {
    func didInput(text: String, cell: TextInputCell) {
        let indexPath = tableView.indexPath(for: cell)
        if indexPath?.row == 0 {
            walletName = text
        } else if indexPath?.row == 1 {
            password = text
        } else if indexPath?.row == 2 {
            subPassword = text
        }
    }
}
