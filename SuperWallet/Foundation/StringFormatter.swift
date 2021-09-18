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

    /// decimalFormatter of a `StringFormatter` to represent curent locale.
    private lazy var decimalFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = ""
        formatter.isLenient = true
        return formatter
    }()

    /// tenthFormatter of a `StringFormatter` to represent Int numbers with grouping.
    private lazy var tenthFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = ","
        formatter.numberStyle = .decimal
        return formatter
    }()

    /// Converts a Decimal to a `currency String`.
    ///
    /// - Parameters:
    ///   - value: Decimal to convert.
    ///   - currencyCode: code of the currency.
    /// - Returns: Currency `String` represenation.
    func currency(with value: Decimal, and currencyCode: String) -> String {
        let formatter = currencyFormatter
        formatter.currencyCode = currencyCode
        return formatter.string(for: value) ?? "\(value)"
    }
}
