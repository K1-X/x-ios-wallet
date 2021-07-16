import UIKit
import TrustCore
import SGPagingView

protocol ImportWalletControllerDelegate: class {
    func didImportAccount(account: WalletInfo, fields: [WalletInfoField], in viewController: ImportWalletController)
}

class ImportWalletController: UIViewController {
    /// 
    private var pageTitleView: SGPageTitleView?
    private var pageContentView: SGPageContentScrollView?
    private var childControllerIndex: NSInteger?
    /// 
    private lazy var addCameraButton: UIButton = {
        let addCameraButton = UIButton(frame: CGRect(x: screenWidth - 40, y: 0, width: 40, height: 40))
        addCameraButton.setImage(UIImage.init(named: "camera"), for: UIControlState.normal)
        return addCameraButton
    }()

    lazy var officialWallet: OfficialWalletController = {
        let officialWallet = OfficialWalletController()
        officialWallet.delegate = self
        return officialWallet
    }()

    lazy var privateWallet: PrivateWalletController = {
        let privateWallet = PrivateWalletController()
        privateWallet.delegate = self
        return privateWallet
    }()


    weak var delegate: ImportWalletControllerDelegate?
    let keystore: Keystore
    let coin: Coin

    init(
        keystore: Keystore,
        for coin: Coin
        ) {
        self.keystore = keystore
        self.coin = coin
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.white
        navigationItem.title = ""
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: R.image.qr_code_scan(), style: .done, target: self, action: #selector(openReader))
        childControllerIndex = 0
        self.initSubViews()
    }

    // MARK: - 
    func initSubViews() {
        let pageTitleH: CGFloat = 50.0

        let configuration = SGPageTitleViewConfigure()
        configuration.titleColor = Colors.lightGray
        configuration.titleSelectedColor = Colors.white
        configuration.indicatorColor = Colors.white
        self.pageTitleView = SGPageTitleView(frame: CGRect(x: 0, y: currentNaviHeight, width: screenWidth, height: pageTitleH), delegate: self, titleNames: ["", ""], configure: configuration)
        self.pageTitleView!.backgroundColor = Colors.blue
        self.view.addSubview(self.pageTitleView!)
        self.pageTitleView?.selectedIndex = 0

        let childArr = [officialWallet, privateWallet]
        self.pageContentView = SGPageContentScrollView(frame: CGRect(x: 0, y: currentNaviHeight+pageTitleH, width: screenWidth, height: self.view.frame.size.height - currentNaviHeight-pageTitleH), parentVC: self, childVCs: childArr)
        self.pageContentView!.delegatePageContentScrollView = self
        self.view.addSubview(self.pageContentView!)
    }

   @objc func openReader() {
        let controller = ScanCodeController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }

    func didImport(account: WalletInfo, name: String) {
        delegate?.didImportAccount(account: account, fields: [
            .name(name),
            .backup(true)
            ], in: self)
    }

    func importWallet(importType: ImportType, remark: String) {
        keystore.importWallet(type: importType, coin: coin) { result in
            self.hideLoading(animated: false)
            switch result {
            case .success(let account):
                self.didImport(account: account, name: "")
            case .failure(let error):
                self.displayError(error: error)
            }
        }
    }
}

extension ImportWalletController: SGPageTitleViewDelegate {
    func pageTitleView(_ pageTitleView: SGPageTitleView!, selectedIndex: Int) {
        self.pageContentView!.setPageContentScrollViewCurrentIndex(selectedIndex)
    }
}

extension ImportWalletController: SGPageContentScrollViewDelegate {
    func pageContentScrollView(_ pageContentScrollView: SGPageContentScrollView!, progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        self.pageTitleView!.setPageTitleViewWithProgress(progress, originalIndex: originalIndex, targetIndex: targetIndex)
        childControllerIndex = targetIndex
        officialWallet.headerView.keystoreView.text = ""
        privateWallet.headerView.keystoreView.text = ""
    }
}

extension ImportWalletController: OfficialWalletControllerDelegate {
    func didPressImportWallet(keystore: String, password: String, viewController: OfficialWalletController) {
        importWallet(importType: .keystore(string: keystore, password: password), remark: "")
    }
}

extension ImportWalletController: PrivateWalletControllerDelegate {
    func didPressImportWallet(privite: String, password: String, remark: String, viewController: PrivateWalletController) {
        importWallet(importType: .privateKey(privateKey: privite, password: password), remark: remark)
    }
}

extension ImportWalletController: ScanCodeControllerDelegate {
    func scanResult(result: String, in controller: ScanCodeController) {
        if childControllerIndex == 0 {
            officialWallet.headerView.keystoreView.text = result
        } else if childControllerIndex == 1 {
            privateWallet.headerView.keystoreView.text = result
        }
    }

    func didCancel(in controller: ScanCodeController) {

    }
}

extension WalletInfo {
    static var emptyName: String {
        return "Unnamed " + R.string.localizable.wallet()
    }

    static func initialName(index numberOfWallets: Int) -> String {
        if numberOfWallets == 0 {
            return R.string.localizable.mainWallet()
        }
        return String(format: "%@ %@", R.string.localizable.wallet(), "\(numberOfWallets + 1)"
        )
    }
}
