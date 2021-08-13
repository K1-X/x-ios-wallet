// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustCore

struct CoinViewModel {

    let coin: Coin

    var displayName: String {
        return "\(name) (\(symbol))"
    }

    var name: String {
        switch coin {
        case .bitcoin: return "Bitcoin"
        case .ethereum: return "SCT"
        case .ethereumClassic: return "ETH"
        case .poa: return "POA Network"
        case .callisto: return "Callisto"
        case .gochain: return "GoChain"
        }
    }

    var symbol: String {
        switch coin {
        case .ethereum: return "SCT"
        case .ethereumClassic: return "ETH"
        case .callisto: return "CLO"
        case .poa: return "POA"
        case .gochain: return "GO"
        case .bitcoin: return "Bitcoin"
        }
    }    

    var image: UIImage? {
        switch coin {
        case .bitcoin: return .none
        case .ethereum: return R.image.sct_logo()
        case .ethereumClassic: return R.image.ethereum_1()
        case .poa: return R.image.ethereum99()
        case .callisto: return R.image.ethereum820()
        case .gochain: return R.image.ethereum60()
        }
    }

    var walletName: String {
        return name + " " + R.string.localizable.wallet()
    }

}
