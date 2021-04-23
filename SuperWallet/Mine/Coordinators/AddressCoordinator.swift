// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import RealmSwift
import TrustCore

enum AddressCoordinatorType: Int {
    case sendVC = 1
    case mineVC
}

protocol AddressCoordinatorDelegate: class {
    func didClickAddress(addressBook: AddressBook ,coordinator: AddressCoordinator)
}

class AddressCoordinator: RootCoordinator {
    var coordinators: [Coordinator] = []
    let keystore: Keystore
    let navigationController: NavigationController
    let sharedRealm: Realm
    weak var delegate: AddressCoordinatorDelegate?
    var type: AddressCoordinatorType?
    lazy var rootViewController: UIViewController = {
        return addressBookController
    }()

   lazy var addressBookController: AddressBookController = {
        let viewModel = AddressBookModel(sharedRealm: sharedRealm)
        let controller = AddressBookController(viewModel: viewModel)
        controller.delegate = self
        return controller
    }()

   init(
        keystore: Keystore,
        navigationController: NavigationController = NavigationController(),
        sharedRealm: Realm
        ) {
        self.keystore = keystore
        self.navigationController = navigationController
        self.sharedRealm = sharedRealm
    }

   func start() {
        navigationController.viewControllers = [rootViewController]
    }


}

extension AddressCoordinator: AddressBookControllerDelegate {

    func didClickAddButton(bookStorage: AddressBookStorage, viewController: AddressBookController) {
        let controller = AddAddressController(
            store: bookStorage)
        navigationController.pushViewController(controller, animated: true)
    }

    func didClickAddress(bookStorage: AddressBookStorage, addressBook: AddressBook, viewController: AddressBookController) {
        if self.type == .sendVC {
            delegate?.didClickAddress(addressBook: addressBook, coordinator: self)
        } else {
            let controller = EditAddressController(
                store: bookStorage,
                addressBook: addressBook)
            navigationController.pushViewController(controller, animated: true)
        }
    }
}
