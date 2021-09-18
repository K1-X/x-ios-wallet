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

    /// Converts a string to a `BigInt`.
    ///
    /// - Parameters:
    ///   - string: string to convert
    ///   - units: units to use
    /// - Returns: `BigInt` represenation.
    func number(from string: String, units: EthereumUnit = .ether) -> BigInt? {
        let decimals = Int(log10(Double(units.rawValue)))
        return number(from: string, decimals: decimals)
    }

    /// Converts a string to a `BigInt`.
    ///
    /// - Parameters:
    ///   - string: string to convert
    ///   - decimals: decimal places used for scaling values.
    /// - Returns: `BigInt` represenation.
    func number(from string: String, decimals: Int) -> BigInt? {
        guard let index = string.index(where: { String($0) == decimalSeparator }) else {
            // No fractional part
            return BigInt(string).flatMap({ $0 * BigInt(10).power(decimals) })
        }

        let fractionalDigits = string.distance(from: string.index(after: index), to: string.endIndex)
        if fractionalDigits > decimals {
            // Can't represent number accurately
            return nil
        }

        var fullString = string
        fullString.remove(at: index)

        guard let number = BigInt(fullString) else {
            return nil
        }

        if fractionalDigits < decimals {
            return number * BigInt(10).power(decimals - fractionalDigits)
        } else {
            return number
        }
    }

    /// Formats a `BigInt` for displaying to the user.
    ///
    /// - Parameters:
    ///   - number: number to format
    ///   - units: units to use
    /// - Returns: string representation
    func string(from number: BigInt, units: EthereumUnit = .ether) -> String {
        let decimals = Int(log10(Double(units.rawValue)))
        return string(from: number, decimals: decimals)
    }

    /// Formats a `BigInt` for displaying to the user.
    ///
    /// - Parameters:
    ///   - number: number to format
    ///   - decimals: decimal places used for scaling values.
    /// - Returns: string representation
    func string(from number: BigInt, decimals: Int) -> String {
        precondition(minimumFractionDigits >= 0)
        precondition(maximumFractionDigits >= 0)

        let dividend = BigInt(10).power(decimals)
        let (integerPart, remainder) = number.quotientAndRemainder(dividingBy: dividend)
        let integerString = self.integerString(from: integerPart)
        let fractionalString = self.fractionalString(from: BigInt(sign: .plus, magnitude: remainder.magnitude), decimals: decimals)
        if fractionalString.isEmpty {
            return integerString
        }
        return "\(integerString).\(fractionalString)"
    }
}
