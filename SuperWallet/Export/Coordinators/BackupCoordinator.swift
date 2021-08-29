import Foundation
import UIKit
import Result
import TrustCore
import TrustKeystore

protocol BackupCoordinatorDelegate: class {
    func didCancel(coordinator: BackupCoordinator)
    func didFinish(wallet: Wallet, in coordinator: BackupCoordinator)
}

final class BackupCoordinator: Coordinator {

    let navigationController: NavigationController
    weak var delegate: BackupCoordinatorDelegate?
    let keystore: Keystore
    let account: Account
    var coordinators: [Coordinator] = []

    init(
        navigationController: NavigationController,
        keystore: Keystore,
        account: Account
    ) {
        self.navigationController = navigationController
        self.navigationController.modalPresentationStyle = .formSheet
        self.keystore = keystore
        self.account = account
    }

    func start() {
        export(for: account)
    }

    func finish(result: Result<Bool, AnyError>) {
        switch result {
        case .success:
            delegate?.didFinish(wallet: account.wallet!, in: self)
        case .failure:
            delegate?.didCancel(coordinator: self)
        }
    }

}

