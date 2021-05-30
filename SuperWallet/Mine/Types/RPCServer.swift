// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustCore

enum RPCServer: Int {
	case main = 1
    case geth = 3
    case sct_02 = 2
    case sct_lb = 4    

    var pkId: Int {
        switch self {
        case .main: return 1
        case .geth: return 3
        case .sct_02: return 2
        case .sct_lb: return 4
        }
    }

    var chainID: String {
        switch self {
        case .main: return "DEFAULT"
        case .geth: return "GETH"
        case .sct_02: return "SCT_02"
        case .sct_lb: return "SCT_LB"
        }
    }

    var priceID: Address {
        switch self {
        case .main: return EthereumAddress(string: "0x000000000000000000000000000000000000003c")!
        case .geth: return EthereumAddress(string: "0x00000000000000000000000000000000000000AC")!
        case .sct_02: return EthereumAddress(string: "0x000000000000000000000000000000000000003D")!
        case .sct_lb: return EthereumAddress(string: "0x0000000000000000000000000000000000000334")!
        }
    }

    var isDisabledByDefault: Bool {
        switch self {
        case .main: return false
        case .geth: return false
        case .sct_02: return true
        case .sct_lb: return true
        }
    }
}
