// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import BigInt
import TrustCore
import WebKit

enum DappAction {
    case signMessage(String)
    case signPersonalMessage(String)
    case signTypedMessage([EthTypedData])
    case signTransaction(UnconfirmedTransaction)
    case sendTransaction(UnconfirmedTransaction)
    case unknown
}
