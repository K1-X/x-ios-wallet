import UIKit
import TrustCore
import SGPagingView

protocol ImportWalletControllerDelegate: class {
    func didImportAccount(account: WalletInfo, fields: [WalletInfoField], in viewController: ImportWalletController)
}
