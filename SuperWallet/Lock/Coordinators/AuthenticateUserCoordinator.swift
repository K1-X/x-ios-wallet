// Copyright DApps Platform Inc. All rights reserved.

import Foundation

final class AuthenticateUserCoordinator: Coordinator {

    var coordinators: [Coordinator] = []
    let navigationController: NavigationController
    private let model: LockEnterPasscodeViewModel
    private let lock: LockInterface
    private lazy var lockEnterPasscodeViewController: GestureVerifyViewController = {
        return GestureVerifyViewController()
    }()
    
}
