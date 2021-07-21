import UIKit

protocol OfficialWalletControllerDelegate: class {
    func didPressImportWallet(keystore: String,
                              password: String,
                              viewController: OfficialWalletController
    )
}

final class OfficialWalletController: UIViewController {

    weak var delegate: OfficialWalletControllerDelegate?
    var dataArray = ["keystore"]
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

    lazy var headerView: ImportWalletHeaderView = {
        let headerView: ImportWalletHeaderView = ImportWalletHeaderView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 200))
        headerView.backgroundColor = Colors.veryLightGray
        return headerView
    }()


    lazy var footerView: UIView = {
        let footerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 156))
        footerView.backgroundColor = Colors.veryLightGray
        let importWalletButton: UIButton = UIButton(type: .custom)
        importWalletButton.setBackgroundColor(Colors.blue, forState: .normal)
        importWalletButton.layer.cornerRadius = importWalletButton.frame.size.height/2.0
        importWalletButton.layer.masksToBounds = true
        importWalletButton.setTitleColor(Colors.white, for: .normal)
        importWalletButton.setTitle("", for: .normal)
        importWalletButton.addTarget(self, action: #selector(importWallet), for: .touchUpInside)
        footerView.addSubview(importWalletButton)
        importWalletButton.snp.makeConstraints({ (make) in
            make.top.equalToSuperview().offset(30)
            make.leading.equalToSuperview().offset(edgeWidth)
            make.trailing.equalToSuperview().offset(-edgeWidth)
            make.height.equalTo(48)
        })
        return footerView
    }()

    var keystoreStr: String?
    var password: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        navigationItem.title = ""
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        tableView.separatorStyle = .none
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            self.automaticallyAdjustsScrollViewInsets = false
        }

        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        tableView.layoutIfNeeded()
    }

    @objc func importWallet() {
        keystoreStr = headerView.keystoreView.text
        guard let password = password, let keystore = keystoreStr  else {
            return
        }
        delegate?.didPressImportWallet(keystore: keystore, password: password, viewController: self)
    }

}

extension OfficialWalletController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let textInputCell: TextInputCell = tableView.dequeueReusableCell(withIdentifier: R.nib.textInputCell.name) as! TextInputCell
        textInputCell.delegate = self
        textInputCell.setPlaceholder(placeholder: dataArray[indexPath.row])
        textInputCell.inputTextField.isSecureTextEntry = true
        textInputCell.contentView.backgroundColor = Colors.veryLightGray
        return textInputCell
    }
}
