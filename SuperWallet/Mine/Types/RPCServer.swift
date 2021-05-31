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

    var name: String {
        switch self {
        case .main: return "v1"
        case .geth: return "Ethereum"
        case .sct_02: return "v3"
        case .sct_lb: return ""
        }
    }

    var displayName: String {
        return "\(self.name) (\(self.symbol))"
    }

    var symbol: String {
        switch self {
        case .main: return "SCT"
        case .geth: return "ETH"
        case .sct_02: return "SCT_02"
        case .sct_lb: return "SCT_LB"
        }
    }

    var isDisabled: Bool {
        switch self {
        case .main:
            return false
        case .geth:
            return false
        case .sct_02:
            return false
        case .sct_lb:
            return false
        }
    }

    var decimals: Int {
        return 18
    }

    var rpcURL: URL {
        let urlString: String = {
            return UserDefaults.standard.object(forKey: DefaultServer)
            }() as! String
        return URL(string: urlString)!
    }

    var remoteURL: URL {
        let urlString: String = {
            switch self {
            case .main: return "http://116.62.160.218:8080"
            case .geth: return "http://47.105.173.168:8080"
            case .sct_02: return "http://116.62.160.218/sct02"
            case .sct_lb: return "http://47.105.173.168/sctlb"
            }
        }()
        return URL(string: urlString)!
    }

    var ensContract: EthereumAddress {
        // https://docs.ens.domains/en/latest/introduction.html#ens-on-ethereum
        switch self {
        case .main:
            return EthereumAddress(string: "0x314159265dd8dbb310642f98f50c066173c1259b")!
        case .geth:
            return EthereumAddress.zero
        case .sct_02:
            return EthereumAddress.zero
        case .sct_lb:
            return EthereumAddress.zero
        }
    }

    var openseaPath: String {
        switch self {
        case .main, .geth, .sct_02, .sct_lb: return Constants.dappsOpenSea
        }
    }

    var openseaURL: URL? {
        return URL(string: openseaPath)
    }

    func opensea(with contract: String, and id: String) -> URL? {
        return URL(string: (openseaPath + "/assets/\(contract)/\(id)"))
    }

    var coin: Coin {
        switch self {
        case .main, .geth, .sct_02, .sct_lb: return Coin.ethereum
        }
    }
}

extension RPCServer: Equatable {
    static func == (lhs: RPCServer, rhs: RPCServer) -> Bool {
        switch (lhs, rhs) {
        case (let lhs, let rhs):
            return lhs.chainID == rhs.chainID
        }
    }
}

