// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustCore
import UIKit
import RealmSwift
protocol MineCoordinatorDelegate: class {
    func didSelectChain()
    func selectWalletTab()
}

final class MineCoordinator: Coordinator {

    let navigationController: NavigationController
    let keystore: Keystore
    let session: WalletSession
    let walletStorage: WalletStorage
    weak var delegate: MineCoordinatorDelegate?
    var coordinators: [Coordinator] = []
 
    lazy var rootViewController: MineViewController = {
        let controller = MineViewController(
            session: session,
            keystore: keystore
        )
        controller.delegate = self
        controller.modalPresentationStyle = .pageSheet
        return controller
    }()

    init(
        navigationController: NavigationController = NavigationController(),
        keystore: Keystore,
        session: WalletSession,
        walletStorage: WalletStorage
        ) {
        self.navigationController = navigationController
        self.navigationController.modalPresentationStyle = .formSheet
        self.keystore = keystore
        self.session = session
        self.walletStorage = walletStorage
    }

    func start() {
        navigationController.viewControllers = [rootViewController]
    }

    private func realm(for config: Realm.Configuration) -> Realm {
        return try! Realm(configuration: config)
    }

    private func showWallets() {
        let coordinator = WalletsCoordinator(keystore: keystore, navigationController: navigationController)
        addCoordinator(coordinator)
        navigationController.pushCoordinator(coordinator: coordinator, animated: true)
    }

    private func showAddressBook() {
        let sharedMigration = SharedMigrationInitializer()
        sharedMigration.perform()
        let sharedRealm = self.realm(for: sharedMigration.config)
        let coordinator = AddressCoordinator(
            keystore: keystore,
            navigationController: navigationController,
            sharedRealm: sharedRealm
        )
        coordinator.type = AddressCoordinatorType.mineVC
        addCoordinator(coordinator)
        navigationController.pushCoordinator(coordinator: coordinator, animated: true)
    }
    
    private func showSetting() {
        let sharedMigration = SharedMigrationInitializer()
        sharedMigration.perform()
        let sharedRealm = self.realm(for: sharedMigration.config)
        let coordinator = SettingsCoordinator(
            keystore: keystore,
            session: session,
            walletStorage: walletStorage,
            sharedRealm: sharedRealm
        )
        coordinator.delegate = self
        addCoordinator(coordinator)
        navigationController.pushCoordinator(coordinator: coordinator, animated: true)
    }
}

extension MineCoordinator: MineViewControllerDelegate {
    func didAction(action: MineAction, in viewController: MineViewController) {
        switch action {
        case .publishToken:
            let controller = PublishTokenController(
                session: self.session,
                keystore: self.keystore)
            controller.delegate = self as PublishTokenControllerDelegate
            self.navigationController.pushViewController(controller, animated: true)
        case .addressBook:
            showAddressBook()
        case .walletManager:
            showWallets()
        case .safetyManager:
            break
        case .setting:
            showSetting()
        }
    }
}
