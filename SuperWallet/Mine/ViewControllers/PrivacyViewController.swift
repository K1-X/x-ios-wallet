// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import Eureka
import Branch

final class PrivacyViewController: FormViewController {

    private let viewModel = AnaliticsViewModel()

    private var amountRow: SwitchRow? {
        return form.rowBy(tag: viewModel.answer.rawValue) as? SwitchRow
    }    
}
