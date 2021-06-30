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

    @objc func pushlishToken() {
        guard let name = name, let symbol = symbol, let totalSupply = totalSupply else {
            return
        }
        let totalSupplyBigInt: BigInt = EtherNumberFormatter.full.number(from: totalSupply, decimals: 18)!
        let totalSupplyBigIntString: String = "\(totalSupplyBigInt)"
        network.buildContract(name: name, symbol: symbol, decimal: "18", totalSupply: totalSupplyBigIntString) { result in
            if !result.0.isEmpty {
                let input: String = result.0.drop0x
                let gasLimit: BigInt? = {
                    return EtherNumberFormatter.full.number(from: "\(3000)", units: .kwei)
                }()
                let gasPrice: BigInt? = {
                    return EtherNumberFormatter.full.number(from: "60", units: .gwei)
                }()
                let transfer: Transfer = {
                    return Transfer(server: (self.session.account.coin?.server)!, type: .token(TokenObject()))
                }()

                let token: TokenObject = {
                    return TokenObject(
                        contract: "",
                        name: "",
                        coin: Coin(rawValue: 60)!,
                        type: .ERC20,
                        symbol: "",
                        decimals: 18,
                        value: "0",
                        isCustom: false,
                        isDisabled: true,
                        order: 0,
                        icon: "",
                        supplyTotal: "",
                        version: "",
                        address: "",
                        publisher: "",
                        chainId: (self.chainObject?.chainId)!,
                        isPublish: true
                    )
                }()
                var signTransaction: SignTransaction {
                    let value: BigInt = {
                        return 0
                    }()
                    let address: EthereumAddress? = {
                        return EthereumAddress(string: "")
                    }()
                    let localizedObject: LocalizedOperationObject? = {
                        return LocalizedOperationObject(
                            from: self.session.account.currentAccount.address.description,
                            to: "",
                            contract: "",
                            type: "",
                            value: "0",
                            symbol: self.symbol,
                            name: self.name,
                            decimals: 18
                        )
                    }()

                    let signTransaction = SignTransaction(
                        value: value,
                        account: self.session.account.currentAccount,
                        to: address,
                        nonce: BigInt(-1),
                        data: Data().data(from: input),
                        gasPrice: gasPrice!,
                        gasLimit: gasLimit!,
                        chainID: 0,
                        localizedObject: localizedObject
                    )

                    return signTransaction
                }
                self.displayLoading()
                self.sendTransactionCoordinator.send(transaction: signTransaction) { [weak self] result in
                    guard let `self` = self else { return }
                    switch result {
                    case .success(let type):
                        switch type {
                        case .signedTransaction:
                            self.displayLoading()
                        case .sentTransaction(let transaction):
                            print(transaction.id)
                            print(Thread.current)
                            self.pkHash = transaction.id
                            self.dispatchTimer(timeInterval: 1, handler: { _ in
                                self.getTransactionReceipt()
                            })
                        }
                    case .failure:
                        self.navigationController?.popViewController(animated: true)
                        self.hideLoading()
                    }
                }
            }
        }
    }

    func dispatchTimer(timeInterval: Double, handler: @escaping (DispatchSourceTimer?) -> Void) {
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        self.timer = timer
        timer.schedule(deadline: .now(), repeating: timeInterval)
        timer.setEventHandler {
            DispatchQueue.main.async {
                handler(timer)
            }
        }
        timer.resume()
    }

    @objc func getTransactionReceipt() {
        if self.requestCount >= 100 {
            self.hideLoading()
            self.delegate?.selectWalletTab()
            self.timer?.cancel()
            return
        }
        self.requestCount += 1
        self.timer?.suspend()
        print(self.requestCount)
        let request = GetTransactionReceiptRequest(hash: self.pkHash)
        let server = RPCServer(rawValue: (self.chainObject?.pkId)!)
        Session.send(EtherServiceRequest(for: server!, batch: BatchFactory().create(request))) { result in
            switch result {
            case .success(let receipt):
                self.timer?.cancel()
                self.storePublishToken(contractAddress: receipt.contractAddress, server: server!)
                self.hideLoading()
                self.delegate?.selectWalletTab()
            case .failure:
                self.timer?.resume()
            }
        }
    }

    func storePublishToken(contractAddress: String, server: RPCServer) {
        let totalSupplyBigInt: BigInt = EtherNumberFormatter.full.number(from: self.totalSupply!, decimals: server.decimals)!
        let totalSupply: String = "\(totalSupplyBigInt)"
        let token = TokenObject(
            contract: contractAddress.lowercased(),
            name: self.name!,
            coin: server.coin,
            type: .ERC20,
            symbol: self.symbol!,
            decimals: server.decimals,
            value: totalSupply,
            isCustom: false,
            isDisabled: false,
            order: TokenObject.DEFAULT_ORDER,
            icon: "",
            supplyTotal: totalSupply,
            version: "",
            address: contractAddress.lowercased(),
            publisher: "",
            chainId: server.chainID,
            isPublish: true
        )
        self.session.tokensStorage.add(tokens: [token])
    }

    func dataToDictionary(data: Data) -> [String: Any]? {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            let dic = json as! [String: Any]
            return dic
        } catch {
            print("")
            return nil
        }
    }

    func jsonToData(jsonDic: [String: Any]) -> Data? {
        if !JSONSerialization.isValidJSONObject(jsonDic) {
            print("is not a valid json object")
            return nil
        }
        let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [])
        let str = String(data: data!, encoding: String.Encoding.utf8)
        print("Json Str:\(str!)")
        return data
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PublishTokenController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let textInputCell: TextInputCell = tableView.dequeueReusableCell(withIdentifier: R.nib.textInputCell.name) as! TextInputCell
        textInputCell.setPlaceholder(indexPath: indexPath)
        textInputCell.delegate = self
        return textInputCell
    }
}
