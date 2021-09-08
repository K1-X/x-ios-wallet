import UIKit
import TrustKeystore
import PromiseKit
import Web3Core

class BigBoxListController: UIViewController {

      lazy var tableView: UITableView = {
    let tableView = UITableView(frame: .zero, style: .grouped)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.separatorStyle = .none
    tableView.backgroundColor = Colors.veryLightGray
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableFooterView = UIView()
    tableView.register(UINib(resource: R.nib.boxListCell), forCellReuseIdentifier: R.nib.boxListCell.name)
    return tableView
}()
  
}
