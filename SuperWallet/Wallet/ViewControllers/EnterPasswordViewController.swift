// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import Eureka
import TrustKeystore

protocol EnterPasswordViewControllerDelegate: class {
    func didEnterPassword(password: String, for account: Account, in viewController: EnterPasswordViewController)
}

final class EnterPasswordViewController: FormViewController {

    struct Values {
        static var password = "password"
        static var confirmPassword = "confirmPassword"
    }
    weak var delegate: EnterPasswordViewControllerDelegate?
    private let viewModel = EnterPasswordViewModel()

    var passwordRow: TextFloatLabelRow? {
        return form.rowBy(tag: Values.password) as? TextFloatLabelRow
    }

}
