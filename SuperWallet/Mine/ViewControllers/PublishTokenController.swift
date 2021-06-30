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

}
