import Foundation
import UIKit
import TrustKeystore

protocol VerifyPassphraseViewControllerDelegate: class {
    func didFinish(in controller: VerifyPassphraseViewController, with account: Wallet)
    func didSkip(in controller: VerifyPassphraseViewController, with account: Wallet)
}

