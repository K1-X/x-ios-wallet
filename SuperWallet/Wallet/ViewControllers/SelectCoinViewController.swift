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

}
