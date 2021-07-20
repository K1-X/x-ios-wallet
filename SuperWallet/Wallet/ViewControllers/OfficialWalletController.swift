import UIKit

protocol OfficialWalletControllerDelegate: class {
    func didPressImportWallet(keystore: String,
                              password: String,
                              viewController: OfficialWalletController
    )
}
