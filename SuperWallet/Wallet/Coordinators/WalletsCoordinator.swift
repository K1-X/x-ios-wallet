// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit
import TrustKeystore
import Result

protocol WalletsCoordinatorDelegate: class {
    func didSelect(wallet: WalletInfo, in coordinator: WalletsCoordinator)
    func didCancel(in coordinator: WalletsCoordinator)
    func didUpdateAccounts(in coordinator: WalletsCoordinator)
}

class WalletsCoordinator: RootCoordinator {

    var coordinators: [Coordinator] = []
    let keystore: Keystore
    let navigationController: NavigationController
    weak var delegate: WalletsCoordinatorDelegate?

    lazy var rootViewController: UIViewController = {
        return walletController
    }()

    lazy var walletController: WalletManagerController = {
        let controller = WalletManagerController(keystore: keystore)
        controller.delegate = self
        return controller
    }()

    init(
        keystore: Keystore,
        navigationController: NavigationController = NavigationController()
    ) {
        self.keystore = keystore
        self.navigationController = navigationController
    }

    @objc func dismiss() {
        delegate?.didCancel(in: self)
    }
   
    func start() {
        navigationController.viewControllers = [rootViewController]
        walletController.fetch()
    }

    @objc func add() {
        showCreateWallet()
    }

    func showCreateWallet() {
        let coordinator = WalletCoordinator(keystore: keystore)
        coordinator.delegate = self
        addCoordinator(coordinator)
        coordinator.start(.welcome)
        navigationController.present(coordinator.navigationController, animated: true, completion: nil)
    }
 
}

