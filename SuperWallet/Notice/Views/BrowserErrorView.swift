// Copyright DApps Platform Inc. All rights reserved.

import UIKit

protocol BrowserErrorViewDelegate: class {
    func didTapReload(_ sender: Button)
}

final class BrowserErrorView: UIView {

    weak var delegate: BrowserErrorViewDelegate?

    private let topMargin: CGFloat = 120
    private let leftMargin: CGFloat = 40
    private let buttonTopMargin: CGFloat = 6

    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = Colors.gray
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var reloadButton: Button = {
        let button = Button(size: .normal, style: .borderless)
        button.addTarget(self, action: #selector(reloadTapped), for: .touchUpInside)
        button.setTitle(NSLocalizedString("browser.reload.button.title", value: "Reload", comment: ""), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.sizeToFit()
        return button
    }()

    init() {
        super.init(frame: CGRect.zero)
        finishInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        finishInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func show(error: Error) {
        self.isHidden = false
        textLabel.text = error.localizedDescription
        textLabel.textAlignment = .center
        textLabel.setNeedsLayout()
    }

    @objc func reloadTapped() {
        delegate?.didTapReload(reloadButton)
    }
}

