// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit
import TrustCore

protocol SelectCoinViewControllerDelegate: class {
    func didSelect(coin: Coin, in controller: SelectCoinViewController)
}

class SelectCoinViewController: UIViewController {

    lazy var viewModel: SelectCoinsViewModel = {
        let elements = coins.map { CoinViewModel(coin: $0) }
        return SelectCoinsViewModel(elements: elements)
    }()
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Colors.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(resource: R.nib.coinViewCell), forCellReuseIdentifier: R.nib.coinViewCell.name)
        return tableView
    }()
    let coins: [Coin]

    weak var delegate: SelectCoinViewControllerDelegate?

    init(
        coins: [Coin]
    ) {
        self.coins = coins
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = viewModel.title
        view.backgroundColor = Colors.white
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
        tableView.layoutIfNeeded()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SelectCoinViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.coinViewCell.name, for: indexPath) as! CoinViewCell
        cell.configure(for: viewModel.cellViewModel(for: indexPath))
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
}
