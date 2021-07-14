// Copyright DApps Platform Inc. All rights reserved.

import UIKit

enum DetailsViewType: Int {
    case tokens
    case nonFungibleTokens
}

class WalletViewController: UIViewController {
    fileprivate lazy var segmentController: UISegmentedControl = {
        let items = [
            R.string.localizable.tokens(),
            R.string.localizable.collectibles()
        ]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = DetailsViewType.tokens.rawValue
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        let titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        let selectedTextAttributes = [NSAttributedStringKey.foregroundColor: Colors.blue]
        segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentedControl.setDividerImage(UIImage.filled(with: UIColor.white), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        for selectView in segmentedControl.subviews {
            selectView.tintColor = UIColor.white
        }
        return segmentedControl
    }()

    var tokensViewController: TokensViewController
    var nonFungibleTokensViewController: NonFungibleTokensViewController

    init(
        tokensViewController: TokensViewController,
        nonFungibleTokensViewController: NonFungibleTokensViewController
    ) {
        self.tokensViewController = tokensViewController
        self.nonFungibleTokensViewController = nonFungibleTokensViewController
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView = segmentController
        setupView()
    }

}
