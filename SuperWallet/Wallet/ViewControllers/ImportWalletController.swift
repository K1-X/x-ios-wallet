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
}
