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
}
