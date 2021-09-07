// Copyright DApps Platform Inc. All rights reserved.

import Foundation

enum AddressValidatorType {
    case ethereum

    var addressLength: Int {
        switch self {
        case .ethereum: return 42
        }
    }
}
