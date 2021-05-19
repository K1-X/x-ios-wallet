// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit
import StatefulViewController


protocol BookmarkViewControllerDelegate: class {
    func didSelectBookmark(_ bookmark: Bookmark, in viewController: BookmarkViewController)
}
