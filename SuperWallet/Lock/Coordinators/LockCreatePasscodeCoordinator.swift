// Copyright DApps Platform Inc. All rights reserved.

import UIKit

protocol LockCreatePasscodeCoordinatorDelegate: class {
    func didCancel(in coordinator: LockCreatePasscodeCoordinator)
}

final class LockCreatePasscodeCoordinator: Coordinator {

    var coordinators: [Coordinator] = []
    private let model: LockCreatePasscodeViewModel
    let navigationController: NavigationController
    weak var delegate: LockCreatePasscodeCoordinatorDelegate?    
}
