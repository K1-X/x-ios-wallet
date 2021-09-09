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

func requestData() {
    self.navigationController!.topViewController?.displayLoading()
    let web3 = Web3(rpcURL: "http://sctim.cn/sy")
    let contractAddress = try! EthereumAddress(hex: bigBoxAddress, eip55: false)
    let contract = web3.eth.Contract(type: BigPackingBoxContract.self, address: contractAddress)
    firstly {
        contract.boxList().callWithFrom(from: contractAddress)
        }.done { outputs in
            let boxList: String = outputs["_boxes"] as! String
            let addressList:[String] = boxList.components(separatedBy: "$");
            self.boxList = addressList
            self.tableView.reloadData()
            self.navigationController!.topViewController?.hideLoading()
        }.catch { error in
            self.navigationController!.topViewController?.hideLoading()
    }
}

    @objc func sourceDetail() {
        let controller = BoxListController(privateKey: privateKey,boxAddress:address,session: session);
        navigationController?.pushViewController(controller, animated: true)
    }
}  
}
