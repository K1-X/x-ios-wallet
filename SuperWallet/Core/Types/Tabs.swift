// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustCore

enum WalletAction {
    case none
    case addToken(Address)
}

enum Tabs {
    case wallet(WalletAction)
    case transactions
    case browser(openURL: URL?)
    case mine

    var index: Int {
        switch self {
        case .wallet: return 0
        case .transactions: return 1
        case .browser: return 2
        case .mine: return 3
        }
    }
}

extension Tabs: Equatable {
    static func == (lhs: Tabs, rhs: Tabs) -> Bool {
        switch (lhs, rhs) {
        case (let .browser(lhs), let .browser(rhs)):
            return lhs == rhs
        case (.wallet, .wallet),
             (.transactions, .transactions),
             (.mine, .mine):
            return true
        case (_, .wallet),
             (_, .transactions),
             (_, .browser),
             (_, .mine):
            return false
        }
    }
}
