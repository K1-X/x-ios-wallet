import UIKit import TrustKeystore
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

var address:String = ""
var boxList: [String] = []
let privateKey: String
let bigBoxAddress: String
let session: WalletSession
init(
    privateKey: String,
    boxAddress: String,
    session: WalletSession
    ) {
    self.privateKey = privateKey
    self.bigBoxAddress = boxAddress
    self.session = session
    super.init(nibName: nil, bundle: nil)
}

    required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
}
override func viewDidLoad() {
    super.viewDidLoad()
    title = ""
    view.addSubview(tableView)
    tableView.snp.makeConstraints { (make) in
        make.leading.trailing.bottom.equalToSuperview()
        make.top.equalToSuperview().offset(currentNaviHeight)
    }
    self.requestData()
}
  
}
