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

    func start() {
        navigationController.viewControllers = [rootViewController]
//        rootViewController.browserViewController.goHome()
    }

    @objc func dismiss() {
        navigationController.dismiss(animated: true, completion: nil)
    }

 private func executeTransaction(account: Account, action: DappAction, callbackID: Int, transaction: UnconfirmedTransaction, type: ConfirmType, server: RPCServer) {
        let configurator = TransactionConfigurator(
            session: session,
            account: account,
            transaction: transaction,
            server: server,
            chainState: ChainState(server: server)
        )
        let coordinator = ConfirmCoordinator(
            session: session,
            configurator: configurator,
            keystore: keystore,
            account: account,
            type: type,
            server: server
        )
        addCoordinator(coordinator)
        coordinator.didCompleted = { [unowned self] result in
            switch result {
            case .success(let type):
                switch type {
                case .signedTransaction(let transaction):
                    // on signing we pass signed hex of the transaction
                    let callback = DappCallback(id: callbackID, value: .signTransaction(transaction.data))
//                    self.rootViewController.browserViewController.notifyFinish(callbackID: callbackID, value: .success(callback))
                    self.delegate?.didSentTransaction(transaction: transaction, in: self)
                case .sentTransaction(let transaction):
                    // on send transaction we pass transaction ID only.
                    let data = Data(hex: transaction.id)
                    let callback = DappCallback(id: callbackID, value: .sentTransaction(data))
//                    self.rootViewController.browserViewController.notifyFinish(callbackID: callbackID, value: .success(callback))
                    self.delegate?.didSentTransaction(transaction: transaction, in: self)
                }
            case .failure: break
//                self.rootViewController.browserViewController.notifyFinish(
//                    callbackID: callbackID,
//                    value: .failure(DAppError.cancelled)
//                )
            }
            coordinator.didCompleted = nil
            self.removeCoordinator(coordinator)
            self.navigationController.dismiss(animated: true, completion: nil)
        }
        coordinator.start()
        navigationController.present(coordinator.navigationController, animated: true, completion: nil)
    }
    func openURL(_ url: URL) {
//        rootViewController.browserViewController.goTo(url: url)
        handleToolbar(for: url)
    }

    func handleToolbar(for url: URL) {
        let isToolbarHidden = url.absoluteString != Constants.dappsBrowserURL
        navigationController.isToolbarHidden = isToolbarHidden

        if isToolbarHidden {
//            rootViewController.select(viewType: .browser)
        }
    }

    func signMessage(with type: SignMesageType, account: Account, callbackID: Int) {
        let coordinator = SignMessageCoordinator(
            navigationController: navigationController,
            keystore: keystore,
            account: account
        )
        coordinator.didComplete = { [weak self] result in
            guard let `self` = self else { return }
            switch result {
            case .success(let data):
                let callback: DappCallback
                switch type {
                case .message:
                    callback = DappCallback(id: callbackID, value: .signMessage(data))
                case .personalMessage:
                    callback = DappCallback(id: callbackID, value: .signPersonalMessage(data))
                case .typedMessage:
                    callback = DappCallback(id: callbackID, value: .signTypedMessage(data))
                }
//                self.rootViewController.browserViewController.notifyFinish(callbackID: callbackID, value: .success(callback))
            case .failure: break
//                self.rootViewController.browserViewController.notifyFinish(callbackID: callbackID, value: .failure(DAppError.cancelled))
            }
            coordinator.didComplete = nil
            self.removeCoordinator(coordinator)
        }
        coordinator.delegate = self
        addCoordinator(coordinator)
        coordinator.start(with: type)
    }

    func presentQRCodeReader() {
        let coordinator = ScanQRCodeCoordinator(
            navigationController: NavigationController()
        )
        coordinator.delegate = self
        addCoordinator(coordinator)
        navigationController.present(coordinator.qrcodeController, animated: true, completion: nil)
    }

    private func presentMoreOptions(sender: UIView) {
        let alertController = makeMoreAlertSheet(sender: sender)
        navigationController.present(alertController, animated: true, completion: nil)
    }
