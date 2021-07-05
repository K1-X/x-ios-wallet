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

}

