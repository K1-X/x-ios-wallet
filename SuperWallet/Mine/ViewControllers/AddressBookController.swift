// Copyright DApps Platform Inc. All rights reserved.

import UIKit


protocol AddressBookControllerDelegate: class {
    func didClickAddButton(bookStorage: AddressBookStorage, viewController: AddressBookController)
    func didClickAddress(bookStorage: AddressBookStorage, addressBook: AddressBook, viewController: AddressBookController)
}

class AddressBookController: UIViewController {

    private var config = Config()
    var viewModel: AddressBookModel
    weak var delegate: AddressBookControllerDelegate?
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Colors.veryLightGray
        tableView.backgroundColor = Colors.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(resource: R.nib.addressBookCell), forCellReuseIdentifier: R.nib.addressBookCell.name)
        return tableView
    }()

    init(viewModel: AddressBookModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

}

