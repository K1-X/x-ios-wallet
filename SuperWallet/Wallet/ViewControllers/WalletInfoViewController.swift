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

    lazy var saveBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
    }()

    init(
        wallet: WalletInfo
    ) {
        self.wallet = wallet
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = viewModel.title
        navigationItem.rightBarButtonItem = saveBarButtonItem

        form +++ Section()

        <<< AppFormAppearance.textFieldFloat(tag: Values.name) {
            $0.add(rule: RuleRequired())
            $0.value = self.viewModel.name
        }.cellUpdate { [weak self] cell, _ in
            cell.textField.placeholder = self?.viewModel.nameTitle
            cell.textField.rightViewMode = .always
        }

        for types in viewModel.sections {
            let newSection = Section(footer: types.footer ?? "")
            for type in types.rows {
                newSection.append(link(item: type))
            }
            form +++ newSection
        }
    }
}

