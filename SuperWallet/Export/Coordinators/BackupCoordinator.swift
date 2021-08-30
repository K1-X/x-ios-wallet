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

    func presentActivityViewController(for account: Account, password: String, newPassword: String, completion: @escaping (Result<Bool, AnyError>) -> Void) {
        navigationController.topViewController?.displayLoading(
            text: NSLocalizedString("export.presentBackupOptions.label.title", value: "Preparing backup options...", comment: "")
        )
        keystore.export(account: account, password: password, newPassword: newPassword) { [weak self] result in
            guard let `self` = self else { return }
            self.handleExport(result: result, completion: completion)
        }
    }
    private func handleExport(result: (Result<String, KeystoreError>), completion: @escaping (Result<Bool, AnyError>) -> Void) {
        switch result {
        case .success(let value):
            let url = URL(fileURLWithPath: NSTemporaryDirectory().appending("super_backup_\(account.address.description).json"))
            do {
                try value.data(using: .utf8)!.write(to: url)
            } catch {
                return completion(.failure(AnyError(error)))
            }

            let activityViewController = UIActivityViewController.make(items: [url])
            activityViewController.completionWithItemsHandler = { _, result, _, error in
                do {
                    try FileManager.default.removeItem(at: url)
                } catch { }
                guard let error = error else {
                    return completion(.success(result))
                }
                completion(.failure(AnyError(error)))
            }
            let presenterViewController = navigationController.topViewController

            activityViewController.popoverPresentationController?.sourceView = presenterViewController?.view
            activityViewController.popoverPresentationController?.sourceRect = presenterViewController?.view.centerRect ?? .zero
            presenterViewController?.present(activityViewController, animated: true) { [weak presenterViewController] in
                presenterViewController?.hideLoading()
            }
        case .failure(let error):
            navigationController.topViewController?.hideLoading()
            navigationController.topViewController?.displayError(error: error)
        }
    }

    func presentShareActivity(for account: Account, password: String, newPassword: String) {
        self.presentActivityViewController(for: account, password: password, newPassword: newPassword) { result in
            self.finish(result: result)
        }
    }
}

