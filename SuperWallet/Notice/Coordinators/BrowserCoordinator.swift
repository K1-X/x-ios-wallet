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

private let sharedRealm: Realm
    private lazy var bookmarksStore: BookmarksStore = {
        return BookmarksStore(realm: sharedRealm)
    }()
    private lazy var historyStore: HistoryStore = {
        return HistoryStore(realm: sharedRealm)
    }()
    lazy var preferences: PreferencesController = {
        return PreferencesController()
    }()
    var urlParser: BrowserURLParser {
        let engine = SearchEngine(rawValue: preferences.get(for: .browserSearchEngine)) ?? .default
        return BrowserURLParser(engine: engine)
    }

    var server: RPCServer {
        return session.currentRPC
    }

    weak var delegate: BrowserCoordinatorDelegate?

    var enableToolbar: Bool = true {
        didSet {
            navigationController.isToolbarHidden = !enableToolbar
        }
    }

   init(
        session: WalletSession,
        keystore: Keystore,
        navigator: Navigator,
        sharedRealm: Realm
    ) {
        self.navigationController = NavigationController()
        self.session = session
        self.keystore = keystore
        self.sharedRealm = sharedRealm
    }
