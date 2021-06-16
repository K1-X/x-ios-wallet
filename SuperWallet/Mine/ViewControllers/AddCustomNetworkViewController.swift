// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import Eureka
import Result

final class AddCustomNetworkViewController: FormViewController {

    let viewModel = AddCustomNetworkViewModel()

    private struct Values {
        static let chainID = "chainID"
        static let name = "name"
        static let symbol = "symbol"
        static let endpoint = "endpoint"
    }
    weak var delegate: NewTokenViewControllerDelegate?

    private var chainIDRow: TextFloatLabelRow? {
        return form.rowBy(tag: Values.chainID) as? TextFloatLabelRow
    }    

    private var nameRow: TextFloatLabelRow? {
        return form.rowBy(tag: Values.name) as? TextFloatLabelRow
    }
    private var symbolRow: TextFloatLabelRow? {
        return form.rowBy(tag: Values.symbol) as? TextFloatLabelRow
    }
}
