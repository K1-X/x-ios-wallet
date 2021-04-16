// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit
import BigInt
import TrustKeystore
import RealmSwift
import URLNavigator
import WebKit
import Branch

protocol BrowserCoordinatorDelegate: class {
    func didSentTransaction(transaction: SentTransaction, in coordinator: BrowserCoordinator)
}

final class BrowserCoordinator: NSObject, Coordinator {
     var coordinators: [Coordinator] = []
    let session: WalletSession
    let keystore: Keystore
    let navigationController: NavigationController   
}

lazy var bookmarksViewController: BookmarkViewController = {
        let controller = BookmarkViewController(bookmarksStore: bookmarksStore)
        controller.delegate = self
        return controller
    }()

    lazy var historyViewController: HistoryViewController = {
        let controller = HistoryViewController(store: historyStore)
        controller.delegate = self
        return controller
    }()

    lazy var rootViewController: AdViewController = {
        let controller = AdViewController()
        return controller
    }()

    lazy var browserViewController: BrowserViewController = {
        let controller = BrowserViewController(account: session.account, config: session.config, server: server)
        controller.delegate = self
        controller.webView.uiDelegate = self
        return controller
    }()
