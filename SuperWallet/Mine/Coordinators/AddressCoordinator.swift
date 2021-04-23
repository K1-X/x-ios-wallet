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
