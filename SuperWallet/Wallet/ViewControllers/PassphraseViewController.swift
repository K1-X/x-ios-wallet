// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit
import TrustKeystore

protocol PassphraseViewControllerDelegate: class {
    func didPressVerify(in controller: PassphraseViewController, with account: Wallet, words: [String])
}

