// Copyright DApps Platform Inc. All rights reserved.

import Foundation

struct ParserResult {
    let protocolName: String
    let address: String
    let params: [String: String]
}


struct QRURLParser {
    static func from(string: String) -> ParserResult? {
        let parts = string.components(separatedBy: ":")
        if parts.count == 1, let address = parts.first, CryptoAddressValidator.isValidAddress(address) {
            return ParserResult(
                protocolName: "",
                address: address,
                params: [:]
            )
        }

        if parts.count == 2, let address = QRURLParser.getAddress(from: parts.last), CryptoAddressValidator.isValidAddress(address) {
            let uncheckedParamParts = Array(parts[1].components(separatedBy: "?")[1...])
            let paramParts = uncheckedParamParts.isEmpty ? [] : Array(uncheckedParamParts[0].components(separatedBy: "&"))
            let params = QRURLParser.parseParamsFromParamParts(paramParts: paramParts)
            return ParserResult(
                protocolName: parts.first ?? "",
                address: address,
                params: params
            )
        }

        return nil
    }

}


