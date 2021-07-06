// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import MBProgressHUD
import TrustKeystore

protocol UpdatePasswordControllerDelegate: class {
    func updatePassword(wallet: Wallet, newPassword: String)
}

class UpdatePasswordController: UIViewController {
    @IBOutlet weak var currentPasswordTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var submitTextField: UITextField!
    @IBOutlet weak var noticeLabel: UILabel!

    let viewModel: WalletAccountViewModel
    weak var delegate: UpdatePasswordControllerDelegate?
    var text: String = ""

    init(viewModel: WalletAccountViewModel,
        nibName: String?,
        bundle: Bundle?
        ) {
        self.viewModel = viewModel
        super.init(nibName: nibName, bundle: bundle)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.veryLightGray
        navigationItem.title = viewModel.title + "-" + R.string.localizable.changePasswordNaviTitle()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: R.string.localizable.changePasswordDoneTitle(), style: .done, target: self, action: #selector(changePassword))
        setUpViews()
    }
}

