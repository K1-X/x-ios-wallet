// Copyright DApps Platform Inc. All rights reserved.

import UIKit

protocol BrowserNavigationBarDelegate: class {
    func did(action: BrowserNavigation)
}

final class BrowserNavigationBar: UINavigationBar {

    let textField = UITextField()
    let moreButton = UIButton()
    let homeButton = UIButton()
    let backButton = UIButton()
    weak var browserDelegate: BrowserNavigationBarDelegate?

    private struct Layout {
        static let width: CGFloat = 34
        static let moreButtonWidth: CGFloat = 24
    }

}
