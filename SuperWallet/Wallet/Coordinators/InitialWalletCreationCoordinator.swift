// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustCore
import UIKit

protocol InitialWalletCreationCoordinatorDelegate: class {
    func didCancel(in coordinator: InitialWalletCreationCoordinator)
    func didAddAccount(_ account: WalletInfo, in coordinator: InitialWalletCreationCoordinator)
}

final class InitialWalletCreationCoordinator: Coordinator {

    let navigationController: NavigationController
    let keystore: Keystore
    var coordinators: [Coordinator] = []
    weak var delegate: InitialWalletCreationCoordinatorDelegate?

    lazy var welcomeViewController: WelcomeViewController = {
        let controller = WelcomeViewController()
        controller.delegate = self
        return controller
    }()
    lazy var rootViewController: WelcomeViewController = {
        return welcomeViewController
    }()
    init(
        navigationController: NavigationController = NavigationController(),
        keystore: Keystore
    ) {
        self.navigationController = navigationController
        self.keystore = keystore
    }

    func start() {
        navigationController.viewControllers = [rootViewController]
    }

    func showCreateWallet() {
        let coordinator = WalletCoordinator(navigationController: navigationController, keystore: keystore)
        coordinator.delegate = self
        coordinator.start(.createInstantWallet)
        navigationController.pushViewController(coordinator.navigationController, animated: true)
        addCoordinator(coordinator)
    }

    func presentImportWallet() {
        let coordinator = WalletCoordinator(keystore: keystore)
        coordinator.delegate = self
        coordinator.start(.importWallet)
        navigationController.pushViewController(coordinator.navigationController, animated: true)
        addCoordinator(coordinator)
    }
}

extension InitialWalletCreationCoordinator: WalletCoordinatorDelegate {

    func didFinish(with account: WalletInfo, in coordinator: WalletCoordinator) {
        delegate?.didAddAccount(account, in: self)
        removeCoordinator(coordinator)
    }

    func didCancel(in coordinator: WalletCoordinator) {
        delegate?.didCancel(in: self)
        removeCoordinator(coordinator)
    }

}

extension InitialWalletCreationCoordinator: WelcomeViewControllerDelegate {
    func didPressCreateWallet(in viewController: WelcomeViewController) {
        showCreateWallet()
    }

    func didPressImportWallet(in viewController: WelcomeViewController) {
        presentImportWallet()
    }
}
