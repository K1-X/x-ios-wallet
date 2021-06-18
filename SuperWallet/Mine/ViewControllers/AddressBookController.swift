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
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.white
        title = R.string.localizable.mineAddressBookTitle()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pushAddAddress))
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(currentNaviHeight)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        tableView.layoutIfNeeded()
    }
}

