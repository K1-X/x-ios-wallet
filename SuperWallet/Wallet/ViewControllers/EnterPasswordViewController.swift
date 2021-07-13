// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import Eureka
import TrustKeystore

protocol EnterPasswordViewControllerDelegate: class {
    func didEnterPassword(password: String, for account: Account, in viewController: EnterPasswordViewController)
}

