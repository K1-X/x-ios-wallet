// Copyright DApps Platform Inc. All rights reserved.

import UIKit

class SecureViewController: UIViewController, Coordinator {

    lazy var lockEnterPasscodeCoordinator: LockEnterPasscodeCoordinator = {
        return LockEnterPasscodeCoordinator(model: LockEnterPasscodeViewModel())
    }()
    
    var coordinators: [Coordinator] = []
    private var config = Config()
    private var lock = Lock()

    var isPasscodeEnabled: Bool {
        return lock.isPasscodeSet()
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Colors.veryLightGray
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(resource: R.nib.gestrueSettingCell), forCellReuseIdentifier: R.nib.gestrueSettingCell.name)
        return tableView
    }()
    var isOpenGestureSetting = false
    var dataList: [[String]]?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.white
        navigationItem.title = ""
        if isPasscodeEnabled {
            let value = lock.getAutoLockType()
            dataList = [
                ["/TouchID", ""],
                ["    ", value.displayName],
                ["", ""]
            ]
        } else {
            dataList = [
                ["/TouchID", ""],
                ["", ""]
            ]
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

    func setPasscode(completion: ((Bool) -> Void)? = .none) {
        let coordinator = LockCreatePasscodeCoordinator(
            model: LockCreatePasscodeViewModel()
        )
        coordinator.delegate = self
        coordinator.start()
        coordinator.lockViewController.willFinishWithResult = { [weak self] result in
            if result {
                let type = AutoLock.immediate
                self?.lock.setAutoLockType(type: type)
            }
            completion?(result)
            self?.navigationController?.dismiss(animated: true, completion: nil)
        }
        addCoordinator(coordinator)
        navigationController?.present(coordinator.navigationController, animated: true, completion: nil)
    }
}
