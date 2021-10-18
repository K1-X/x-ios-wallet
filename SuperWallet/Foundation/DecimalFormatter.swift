import Foundation

final class DecimalFormatter {

    /// Locale of a `DecimalFormatter`.
    var locale: Locale
    /// numberFormatter of a `DecimalFormatter` to represent curent locale.
    private lazy var numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = self.locale
        formatter.numberStyle = .decimal
        formatter.isLenient = true
        return formatter
    }()    

    /// usFormatter of a `DecimalFormatter` to represent decimal separator ".".
    private lazy var usFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.numberStyle = .decimal
        formatter.isLenient = true
        return formatter
    }()

    /// frFormatter of a `DecimalFormatter` to represent decimal separator ",".
    private lazy var frFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "fr_FR")
        formatter.numberStyle = .decimal
        formatter.isLenient = true
        return formatter
    }()

    /// enCaFormatter of a `DecimalFormatter` to represent decimal separator "'".
    private lazy var enCaFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_CA")
        formatter.numberStyle = .decimal
        formatter.isLenient = true
        return formatter
    }()
}
