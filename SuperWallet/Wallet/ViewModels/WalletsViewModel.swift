// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit
import TrustCore

protocol WalletsViewModelProtocol: class {
    func update()
}

class WalletsViewModel {
    private let keystore: Keystore
    private let networks: [WalletInfo] = []
    private let importedWallet: [WalletInfo] = []

    var sections: [WalletAccountViewModel] = []
    private let operationQueue: OperationQueue = OperationQueue()
    weak var delegate: WalletsViewModelProtocol?

    init(
        keystore: Keystore
    ) {
        self.keystore = keystore
    }

}

