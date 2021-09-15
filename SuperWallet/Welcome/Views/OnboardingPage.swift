// Copyright DApps Platform Inc. All rights reserved.

import UIKit

final class OnboardingPage: UICollectionViewCell {
    static let identifier = "Page"
    let style = OnboardingPageStyle()

    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
 
    override var reuseIdentifier: String? {
        return OnboardingPage.identifier
    }

    var model = OnboardingPageViewModel() {
        didSet {
            imageView.image = model.image
            titleLabel.text = model.title
            subtitleLabel.text = model.subtitle
        }
    }    

}
