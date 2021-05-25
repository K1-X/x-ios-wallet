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
