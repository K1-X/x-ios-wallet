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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    @objc func pushAddAddress() {
        delegate?.didClickAddButton(bookStorage: viewModel.addressBookStorage, viewController: self)
    }
}

extension AddressBookController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.addressBookStorage.addresses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let addressBookCell: AddressBookCell = tableView.dequeueReusableCell(withIdentifier: R.nib.addressBookCell.name) as! AddressBookCell
        let addresss = viewModel.addressBookStorage.addresses[indexPath.row]
        addressBookCell.selectionStyle = .none
        addressBookCell.configure(addressBook: addresss)
        return addressBookCell
    }
}

extension AddressBookController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let addressBook = viewModel.addressBookStorage.addresses[indexPath.row]
        delegate?.didClickAddress(bookStorage: viewModel.addressBookStorage, addressBook: addressBook, viewController: self)
    }
}
