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
}
