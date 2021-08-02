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

class DarkVerifyPassphraseViewController: VerifyPassphraseViewController {

}

class SubtitleBackupLabel: UILabel {

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .center
        numberOfLines = 0
        font = AppStyle.paragraph.font
        textColor = Colors.gray
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VerifyPassphraseViewController: UIViewController {

    let contentView = PassphraseView()
    let proposalView = PassphraseView()
    let account: Wallet
    let words: [String]
    let shuffledWords: [String]
    weak var delegate: VerifyPassphraseViewControllerDelegate?

    lazy var doneButton: UIButton = {
        let button = Button(size: .large, style: .solid)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(R.string.localizable.done(), for: .normal)
        button.addTarget(self, action: #selector(doneAction(_:)), for: .touchUpInside)
        return button
    }()

    lazy var subTitleLabel: SubtitleBackupLabel = {
        let label = SubtitleBackupLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = NSLocalizedString("verifyPassphrase.label.title", value: "Tap the words to put them next to each other in the correct order.", comment: "")
        return label
    }()

    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = R.string.localizable.verifyBackupPhrase()
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = .center
        return titleLabel
    }()

    private struct Layout {
        static let contentSize: CGFloat = 140
    }
}
