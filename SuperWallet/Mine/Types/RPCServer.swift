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
}
