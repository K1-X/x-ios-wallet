import UIKit

protocol PrivateWalletControllerDelegate: class {
    func didPressImportWallet(privite: String,
                              password: String,
                              remark: String,
                              viewController: PrivateWalletController
    )
}

final class PrivateWalletController: UIViewController {

    weak var delegate: PrivateWalletControllerDelegate?
    var dataArray = ["", "", "（）"]
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Colors.veryLightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(resource: R.nib.textInputCell), forCellReuseIdentifier: R.nib.textInputCell.name)
        return tableView
    }()

}
