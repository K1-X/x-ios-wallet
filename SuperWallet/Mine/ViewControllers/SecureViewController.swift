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

    func verifyPasscode(completion: ((Bool) -> Void)? = .none) {
        let coordinator = LockCreatePasscodeCoordinator(
            model: LockCreatePasscodeViewModel()
        )
        coordinator.delegate = self
        coordinator.start()
        coordinator.lockViewController.type = GestureViewControllerType.login
        coordinator.lockViewController.willFinishWithResult = { [weak self] result in
            completion?(result)
            self?.navigationController?.dismiss(animated: true, completion: nil)
        }
        addCoordinator(coordinator)
        navigationController?.present(coordinator.navigationController, animated: true, completion: nil)
    }

    func setAutoTime() {
        var alert: UIAlertController!
        alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        let cancelAction = UIAlertAction(title: "", style: .cancel) { (_) in

        }
        let immediateAction = UIAlertAction(title: AutoLock.immediate.displayName, style: .default) { (_) in
            self.lock.removeAutoLockTime()
            self.lock.setAutoLockType(type: AutoLock.immediate)
            let value = self.lock.getAutoLockType()
            self.dataList = [
                ["/TouchID", ""],
                ["    ", value.displayName],
                ["", ""]
            ]
            self.tableView.reloadData()
        }
        let oneMinuteAction = UIAlertAction(title: AutoLock.oneMinute.displayName, style: .default) { (_) in
            self.lock.removeAutoLockTime()
            self.lock.setAutoLockType(type: AutoLock.oneMinute)
            let value = self.lock.getAutoLockType()
            self.dataList = [
                ["/TouchID", ""],
                ["    ", value.displayName],
                ["", ""]
            ]
            self.tableView.reloadData()
        }
        let fiveMinutesAction = UIAlertAction(title: AutoLock.fiveMinutes.displayName, style: .default) { (_) in
            self.lock.removeAutoLockTime()
            self.lock.setAutoLockType(type: AutoLock.fiveMinutes)
            let value = self.lock.getAutoLockType()
            self.dataList = [
                ["/TouchID", ""],
                ["    ", value.displayName],
                ["", ""]
            ]
            self.tableView.reloadData()
        }
        let ioneHourAction = UIAlertAction(title: AutoLock.oneHour.displayName, style: .default) { (_) in
            self.lock.removeAutoLockTime()
            self.lock.setAutoLockType(type: AutoLock.oneHour)
            let value = self.lock.getAutoLockType()
            self.dataList = [
                ["/TouchID", ""],
                ["    ", value.displayName],
                ["", ""]
            ]
            self.tableView.reloadData()
        }
        let fiveHoursAction = UIAlertAction(title: AutoLock.fiveHours.displayName, style: .default) { (_) in
            self.lock.removeAutoLockTime()
            self.lock.setAutoLockType(type: AutoLock.fiveHours)
            let value = self.lock.getAutoLockType()
            self.dataList = [
                ["/TouchID", ""],
                ["    ", value.displayName],
                ["", ""]
            ]
            self.tableView.reloadData()
        }
        alert.addAction(cancelAction)
        alert.addAction(immediateAction)
        alert.addAction(oneMinuteAction)
        alert.addAction(fiveMinutesAction)
        alert.addAction(ioneHourAction)
        alert.addAction(fiveHoursAction)
        self.present(alert, animated: true, completion: nil)
    }
}

extension SecureViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return dataList!.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let gestrueSettingCell: GestrueSettingCell = tableView.dequeueReusableCell(withIdentifier: R.nib.gestrueSettingCell.name) as! GestrueSettingCell
        gestrueSettingCell.confgure(title: dataList![indexPath.section][0], detail: dataList![indexPath.section][1], indexPath: indexPath)
        gestrueSettingCell.selectionStyle = .none
        gestrueSettingCell.delegate = self
        if indexPath.section == 0 {
            gestrueSettingCell.openGesture.isOn = isPasscodeEnabled
        }
        return gestrueSettingCell
    }
}
