import Foundation
import TrustCore
import TrustKeystore
import UIKit

protocol WalletCoordinatorDelegate: class {
    func didFinish(with account: WalletInfo, in coordinator: WalletCoordinator)
    func didCancel(in coordinator: WalletCoordinator)
}

final class WalletCoordinator: Coordinator {

    let navigationController: NavigationController
    weak var delegate: WalletCoordinatorDelegate?
    var entryPoint: WalletEntryPoint?
    let keystore: Keystore
    var coordinators: [Coordinator] = []

    lazy var welcomeViewController: WelcomeViewController = {
        let controller = WelcomeViewController()
        controller.delegate = self
        return controller
    }()

    lazy var importWalletController: ImportWalletController = {
        let controller = ImportWalletController(keystore: keystore, for: Coin.ethereum)
        controller.delegate = self
        return controller
    }()

    lazy var walletCreateController: WalletCreateController = {
        let controller = WalletCreateController(keystore: keystore)
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
        self.navigationController.modalPresentationStyle = .formSheet
        self.keystore = keystore
    }

    func start() {
        navigationController.viewControllers = [rootViewController]
    }

    func start(_ entryPoint: WalletEntryPoint) {
        self.entryPoint = entryPoint
        switch entryPoint {
        case .welcome:break
        case .importWallet:
            pushImportWallet()
        case .createInstantWallet:
            pushCreateWallet()
        }
    }

    private func pushImportWalletView(for coin: Coin) {
        let controller = ImportWalletController(keystore: keystore, for: coin)
        controller.delegate = self
        navigationController.pushViewController(controller, animated: true)
    }

    func importMainWallet() {
        let controller = importWalletController
        controller.navigationItem.leftBarButtonItem =  UIBarButtonItem(image: R.image.icon_back(), style: .plain, target: self, action: #selector(pop))
        navigationController.pushViewController(controller, animated: true)
    }

    func pushImportWallet() {
        importMainWallet()
    }

    func pushCreateWallet() {
        let controller = walletCreateController
        controller.delegate = self
        controller.navigationItem.leftBarButtonItem =  UIBarButtonItem(image: R.image.icon_back(), style: .plain, target: self, action: #selector(pop))
        navigationController.pushViewController(controller, animated: true)
    }

    func createInstantWallet(walletName: String, password: String) {
        let text = R.string.localizable.creatingWallet() + "..."
        navigationController.topViewController?.displayLoading(text: text, animated: false)
        keystore.createAccount(with: password) { result in
            switch result {
            case .success(let account):
                self.markAsMainWallet(for: account, walletName: walletName)
                self.showConfirm(for: account, completedBackup: true)
            case .failure(let error):
                self.navigationController.topViewController?.hideLoading(animated: false)
                self.navigationController.topViewController?.displayError(error: error)
            }
        }
    }

    func pushBackup(for account: Wallet, words: [String]) {
        let controller = DarkPassphraseViewController(
            account: account,
            words: words,
            mode: .showAndVerify
        )
        controller.delegate = self
        controller.navigationItem.backBarButtonItem = nil
        controller.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController.setNavigationBarHidden(false, animated: true)
        navigationController.pushViewController(controller, animated: true)
    }

    @objc func done() {
        delegate?.didCancel(in: self)
    }

    @objc func dismiss() {
        delegate?.didCancel(in: self)
    }
    @objc func pop() {
        navigationController.popViewController(animated: true)
    }

    func didCreateAccount(account: WalletInfo) {
        delegate?.didFinish(with: account, in: self)
    }

    func verify(account: Wallet, words: [String]) {
        let controller = DarkVerifyPassphraseViewController(account: account, words: words)
        controller.delegate = self
        navigationController.setNavigationBarHidden(false, animated: true)
        navigationController.pushViewController(controller, animated: true)
    }

    private func markAsMainWallet(for account: Wallet, walletName: String) {
        let type = WalletType.privateKey(account)
        let wallet = WalletInfo(type: type, info: keystore.storage.get(for: type))
        markAsMainWallet(for: wallet, walletName: walletName)
    }

    private func markAsMainWallet(for wallet: WalletInfo, walletName: String) {
        var initialName = walletName
        if initialName.isEmpty {
            initialName = R.string.localizable.mainWallet()
        }
        keystore.store(object: wallet.info, fields: [
            .name(initialName),
            .mainWallet(false)
        ])
    }

    private func showConfirm(for account: Wallet, completedBackup: Bool) {
        let type = WalletType.privateKey(account)
        let wallet = WalletInfo(type: type, info: keystore.storage.get(for: type))
        showConfirm(for: wallet, type: .created, completedBackup: completedBackup)
    }

    private func showConfirm(for wallet: WalletInfo, type: WalletDoneType, completedBackup: Bool) {
        keystore.store(object: wallet.info, fields: [
            .backup(completedBackup)
        ])
        didCreateAccount(account: wallet)
    }

    func done(for wallet: WalletInfo) {
        didCreateAccount(account: wallet)
    }
}

extension WalletCoordinator: WalletCreateControllerDelegate {
    func didPressCreateWallet(walletName: String, password: String, in viewController: WalletCreateController) {
        createInstantWallet(walletName: walletName, password: password)
    }

    func didPressImportWallet(in viewController: WalletCreateController) {
        pushImportWallet()
    }
}

extension WalletCoordinator: ImportWalletControllerDelegate {
    func didImportAccount(account: WalletInfo, fields: [WalletInfoField], in viewController: ImportWalletController) {
        keystore.store(object: account.info, fields: fields)
        didCreateAccount(account: account)
//        walletCreated(wallet: account, type: .imported)
    }
}

extension WalletCoordinator: PassphraseViewControllerDelegate {
    func didPressVerify(in controller: PassphraseViewController, with account: Wallet, words: [String]) {
        // show verify
        verify(account: account, words: words)
    }
}

