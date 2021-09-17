// Copyright DApps Platform Inc. All rights reserved.

import BigInt
import Foundation

final class EtherNumberFormatter {

    /// Formatter that preserves full precision.
    static let full = EtherNumberFormatter()

    // Formatter that caps the number of decimal digits to 4.
    static let short: EtherNumberFormatter = {
        let formatter = EtherNumberFormatter()
        formatter.maximumFractionDigits = 4
        return formatter
    }()

    /// Minimum number of digits after the decimal point.
    var minimumFractionDigits = 0

    /// Maximum number of digits after the decimal point.
    var maximumFractionDigits = Int.max

    /// Decimal point.
    var decimalSeparator = "."

    /// Thousands separator.
    var groupingSeparator = ","

    /// Initializes a `EtherNumberFormatter` with a `Locale`.
    init(locale: Locale = .current) {
        decimalSeparator = locale.decimalSeparator ?? "."
        groupingSeparator = locale.groupingSeparator ?? ","
    }
}
