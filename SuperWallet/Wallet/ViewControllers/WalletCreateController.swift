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
}
