// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit
import WebKit
import JavaScriptCore
import Result

enum BrowserAction {
    case history
    case addBookmark(bookmark: Bookmark)
    case bookmarks
    case qrCode
    case changeURL(URL)
    case navigationAction(BrowserNavigation)
}
