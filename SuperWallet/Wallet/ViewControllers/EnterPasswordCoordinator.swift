// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustKeystore

protocol EnterPasswordCoordinatorDelegate: class {
    func didEnterPassword(password: String, account: Account, in coordinator: EnterPasswordCoordinator)
    func didCancel(in coordinator: EnterPasswordCoordinator)
}

final class EnterPasswordCoordinator: Coordinator {
    var coordinators: [Coordinator] = []

    weak var delegate: EnterPasswordCoordinatorDelegate?

    lazy var enterPasswordController: EnterPasswordViewController = {
        let controller = EnterPasswordViewController(account: account)
        controller.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismiss))
        controller.delegate = self
        return controller
    }()
    let navigationController: NavigationController
    private let account: Account

}
