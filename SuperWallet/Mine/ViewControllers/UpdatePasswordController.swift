// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import MBProgressHUD
import TrustKeystore

protocol UpdatePasswordControllerDelegate: class {
    func updatePassword(wallet: Wallet, newPassword: String)
}

