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

    func setUpViews() {
        currentPasswordTextField.backgroundColor = Colors.white
        currentPasswordTextField.tintColor = Colors.blue
        currentPasswordTextField.layer.cornerRadius = currentPasswordTextField.frame.size.height/2.0
        currentPasswordTextField.layer.masksToBounds = true
        currentPasswordTextField.isSecureTextEntry = true
        currentPasswordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        currentPasswordTextField.leftViewMode = .always
        currentPasswordTextField.clearButtonMode = .whileEditing
        currentPasswordTextField.placeholder = R.string.localizable.changePasswordCurrentPassword()

        passwordTextField.backgroundColor = Colors.white
        passwordTextField.tintColor = Colors.blue
        passwordTextField.layer.cornerRadius = passwordTextField.frame.size.height/2.0
        passwordTextField.layer.masksToBounds = true
        passwordTextField.isSecureTextEntry = true
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        passwordTextField.leftViewMode = .always
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.placeholder = R.string.localizable.changePasswordInputPassword()

        submitTextField.backgroundColor = Colors.white
        submitTextField.tintColor = Colors.blue
        submitTextField.layer.cornerRadius = passwordTextField.frame.size.height/2.0
        submitTextField.layer.masksToBounds = true
        submitTextField.isSecureTextEntry = true
        submitTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 40))
        submitTextField.leftViewMode = .always
        submitTextField.clearButtonMode = .whileEditing
        submitTextField.placeholder = R.string.localizable.changePasswordSubmitPassword()

        noticeLabel.backgroundColor = UIColor.clear
        noticeLabel.text = R.string.localizable.changePasswordNoticeContent()
        noticeLabel.textColor = Colors.gray
    }

    @objc func changePassword() {
        if checkout() == true {
            delegate?.updatePassword(wallet: viewModel.account.wallet!, newPassword: passwordTextField.text!)
        } else {
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud.mode = .text
            hud.label.text = text
            hud.hide(animated: true, afterDelay: 1.5)
        }
    }
}

