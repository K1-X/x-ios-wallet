// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustCore
import UIKit
import WebKit
import RealmSwift

protocol SettingsCoordinatorDelegate: class {
    func didSelectChain()
}

final class SettingsCoordinator: RootCoordinator {

    let navigationController: NavigationController
    let keystore: Keystore
    let session: WalletSession
    let walletStorage: WalletStorage

    weak var delegate: SettingsCoordinatorDelegate?
    let pushNotificationsRegistrar = PushNotificationsRegistrar()
    var coordinators: [Coordinator] = []
    
    lazy var rootViewController: UIViewController = {
        return settingViewController
    }()

    lazy var settingViewController: SettingViewController = {
        let controller = SettingViewController(
            session: session,
            keystore: keystore
        )
        controller.delegate = self
        controller.modalPresentationStyle = .pageSheet
        return controller
    }()

    let sharedRealm: Realm
    private lazy var historyStore: HistoryStore = {
        return HistoryStore(realm: sharedRealm)
    }()

    init(
        navigationController: NavigationController = NavigationController(),
        keystore: Keystore,
        session: WalletSession,
        walletStorage: WalletStorage,
        sharedRealm: Realm
    ) {
        self.navigationController = navigationController
        self.navigationController.modalPresentationStyle = .formSheet
        self.keystore = keystore
        self.session = session
        self.walletStorage = walletStorage
        self.sharedRealm = sharedRealm
    }

    func start() {
        navigationController.viewControllers = [rootViewController]
    }
}
