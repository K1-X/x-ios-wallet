// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit

protocol MasterBrowserViewControllerDelegate: class {
    func didPressAction(_ action: BrowserToolbarAction)
}

enum BrowserToolbarAction {
    case view(BookmarksViewType)
    case qrCode
}

enum BookmarksViewType: Int {
    case browser
    case bookmarks
    case history
}
final class MasterBrowserViewController: UIViewController {

    private lazy var segmentController: UISegmentedControl = {
        let items = [
            R.string.localizable.new(),
            R.string.localizable.bookmarks(),
            R.string.localizable.history()
        ]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)
        segmentedControl.tintColor = .clear
        return segmentedControl
    }()

    private lazy var qrcodeButton: UIButton = {
        let button = Button(size: .normal, style: .borderless)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(R.image.browser_scan(), for: .normal)
        button.addTarget(self, action: #selector(qrReader), for: .touchUpInside)
        return button
    }()

}

