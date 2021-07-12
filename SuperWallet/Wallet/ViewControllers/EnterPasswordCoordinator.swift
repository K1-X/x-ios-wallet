// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustKeystore

protocol EnterPasswordCoordinatorDelegate: class {
    func didEnterPassword(password: String, account: Account, in coordinator: EnterPasswordCoordinator)
    func didCancel(in coordinator: EnterPasswordCoordinator)
}
