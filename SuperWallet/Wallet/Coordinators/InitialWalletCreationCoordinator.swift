// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustCore
import UIKit

protocol InitialWalletCreationCoordinatorDelegate: class {
    func didCancel(in coordinator: InitialWalletCreationCoordinator)
    func didAddAccount(_ account: WalletInfo, in coordinator: InitialWalletCreationCoordinator)
}

final class InitialWalletCreationCoordinator: Coordinator {

    
}
