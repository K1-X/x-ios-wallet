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

}
