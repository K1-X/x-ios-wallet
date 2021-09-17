// Copyright DApps Platform Inc. All rights reserved.

import UIKit

final class StringFormatter {

    /// currencyFormatter of a `StringFormatter` to represent curent locale.
    private lazy var currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.currencySymbol = ""
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .currencyAccounting
        formatter.isLenient = true
        return formatter
    }()    
}
