// Copyright DApps Platform Inc. All rights reserved.
import UIKit

enum WellDoneAction {
    case other
}


protocol WellDoneViewControllerDelegate: class {
    func didPress(action: WellDoneAction, sender: UIView, in viewController: WellDoneViewController)
}

final class WellDoneViewController: UIViewController {

    weak var delegate: WellDoneViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(image: R.image.mascot_happy())
        imageView.translatesAutoresizingMaskIntoConstraints = false

        let descriptionLabel = UILabel()
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.text = NSLocalizedString("welldone.description.label.text", value: "Help us grow by sharing this app with your friends!", comment: "")
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.textColor = Colors.darkBlue
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center

        let otherButton = Button(size: .normal, style: .solid)
        otherButton.translatesAutoresizingMaskIntoConstraints = false
        otherButton.setTitle(R.string.localizable.share(), for: .normal)
        otherButton.addTarget(self, action: #selector(other(_:)), for: .touchUpInside)

        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            //titleLabel,
            descriptionLabel,
            .spacer(height: 10),
            .spacer(),
            otherButton
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.spacing = 10
}
