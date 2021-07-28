// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit
import TrustCore

protocol SelectCoinViewControllerDelegate: class {
    func didSelect(coin: Coin, in controller: SelectCoinViewController)
}

