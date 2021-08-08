// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import Eureka
import TrustKeystore

protocol WalletInfoViewControllerDelegate: class {
    func didPress(item: WalletInfoType, in controller: WalletInfoViewController)
    func didPressSave(wallet: WalletInfo, fields: [WalletInfoField], in controller: WalletInfoViewController)
}

enum WalletInfoField {
    case name(String)
    case backup(Bool)
    case mainWallet(Bool)
    case balance(String)
}

final class WalletInfoViewController: FormViewController {

    lazy var viewModel: WalletInfoViewModel = {
        return WalletInfoViewModel(wallet: wallet)
    }()
    var segmentRow: TextFloatLabelRow? {
        return form.rowBy(tag: Values.name)
    }
    let wallet: WalletInfo

    weak var delegate: WalletInfoViewControllerDelegate?

    private struct Values {
        static let name = "name"
    }

}

