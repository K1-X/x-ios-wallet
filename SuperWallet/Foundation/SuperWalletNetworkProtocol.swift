// Copyright DApps Platform Inc. All rights reserved.

import Moya

protocol SuperWalletNetworkProtocol {
    var provider: MoyaProvider<SuperWalletAPI> { get }
}
