// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import Eureka
import SnapKit
import BigInt
import TrustCore
import Result
import APIKit
import JSONRPCKit

protocol PublishTokenControllerDelegate: class {
    func selectWalletTab()
}

class PublishTokenController: UIViewController {

    lazy var network: NetworkProtocol = {
        return SuperWalletNetwork(
            provider: SuperWalletProviderFactory.makeProvider(),
            wallet: session.account
        )
    }()
    lazy var sendTransactionCoordinator = { () -> SendTransactionCoordinator in
        let server = RPCServer(rawValue: (chainObject?.pkId)!)
        return SendTransactionCoordinator(session: self.session, keystore: keystore, confirmType: .signThenSend, server: server!)
    }()

    var requestCount = 0
    var pkHash: String = ""
    var timer: DispatchSourceTimer?

    weak var delegate: PublishTokenControllerDelegate?

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = Colors.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib(resource: R.nib.textInputCell), forCellReuseIdentifier: R.nib.textInputCell.name)
        return tableView
    }()

    lazy var footerView: UIView = {
        let footerView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 144))
        footerView.backgroundColor = Colors.white
        let nextButton: UIButton = UIButton(type: .custom)
        nextButton.setBackgroundColor(Colors.blue, forState: .normal)
        nextButton.layer.cornerRadius = 4
        nextButton.layer.masksToBounds = true
        nextButton.setTitleColor(Colors.white, for: .normal)
        nextButton.setTitle(R.string.localizable.publishTokenNextTitle(), for: .normal)
        nextButton.addTarget(self, action: #selector(pushlishToken), for: .touchUpInside)
        footerView.addSubview(nextButton)
        nextButton.snp.makeConstraints({ (make) in
            make.centerY.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(48)
        })
        return footerView
    }()

    var name: String?
    var symbol: String?
    var totalSupply: String?
    var chainObject: ChainObject?

    let session: WalletSession
    let keystore: Keystore

    init(
        session: WalletSession,
        keystore: Keystore
        ) {
        self.session = session
        self.keystore = keystore
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.white
        title = R.string.localizable.minePublishTokenTitle()
        tableView.tableFooterView = footerView
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(currentNaviHeight)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        tableView.layoutIfNeeded()
        let settingChainView: SettingChainView = SettingChainView()
        settingChainView.configure(dataSource: self.session.chainStore.getAllBlocks())
        settingChainView.delegate = self
        settingChainView.show()
    }

}
