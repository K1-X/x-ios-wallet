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

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = Colors.white
        tableView.separatorStyle = .none
        tableView.register(UINib(resource: R.nib.walletManagerCell), forCellReuseIdentifier: R.nib.walletManagerCell.name)
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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WalletManagerController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.walletManagerCell.name, for: indexPath) as! WalletManagerCell
        cell.selectionStyle = .none
        cell.viewModel = viewModel.cellViewModel(for: indexPath)
        return cell
    }
}

extension WalletManagerController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewModel = self.viewModel.cellViewModel(for: indexPath)
        delegate?.didClickWallet(viewModel: viewModel, viewController: self
        )
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.00001
    }
}

extension WalletManagerController: WalletsViewModelProtocol {
    func update() {
        viewModel.refresh()
        tableView.reloadData()
    }
}
