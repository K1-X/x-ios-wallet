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

