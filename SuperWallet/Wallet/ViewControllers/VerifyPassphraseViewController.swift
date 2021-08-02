import Foundation
import UIKit
import TrustKeystore

protocol VerifyPassphraseViewControllerDelegate: class {
    func didFinish(in controller: VerifyPassphraseViewController, with account: Wallet)
    func didSkip(in controller: VerifyPassphraseViewController, with account: Wallet)
}

enum VerifyStatus {
    case empty
    case progress
    case invalid
    case correct

    var text: String {
        switch self {
        case .empty, .progress: return ""
        case .invalid: return NSLocalizedString("verify.passphrase.invalidOrder.title", value: "Invalid order. Try again!", comment: "")
        case .correct:
            return String(format: NSLocalizedString("verify.passphrase.welldone.title", value: "Well done! %@", comment: ""), "✅")
        }
    }

    var textColor: UIColor {
        switch self {
        case .empty, .progress, .correct: return Colors.black
        case .invalid: return Colors.red
        }
    }

    static func from(initialWords: [String], progressWords: [String]) -> VerifyStatus {
        guard !progressWords.isEmpty else { return .empty }

        if initialWords == progressWords && initialWords.count == progressWords.count {
            return .correct
        }

        if progressWords == Array(initialWords.prefix(progressWords.count)) {
            return .progress
        }

        return .invalid
    }
}
