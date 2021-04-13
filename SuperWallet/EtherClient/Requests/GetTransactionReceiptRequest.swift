// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import JSONRPCKit
import TrustCore
import BigInt

struct TransactionReceipt: Encodable {
    let gasUsed: String
//    let status: Bool
    let blockNumber: Int
    let contractAddress: String

}

struct GetTransactionReceiptRequest: JSONRPCKit.Request {
    typealias Response = TransactionReceipt

    let hash: String
    var method: String {
        return "eth_getTransactionReceipt"
    }
    var parameters: Any? {
        return [hash]
    }

    func response(from resultObject: Any) throws -> Response {
        guard
            let dict = resultObject as? [String: AnyObject],
            let gasUsedString = dict["gasUsed"] as? String,
            let blockNumber = dict["blockNumber"] as? Int,
            let contractAddress = dict["contractAddress"] as? String,
            let gasUsed = BigInt(gasUsedString.drop0x, radix: 16)
            else {
                throw CastError(actualValue: resultObject, expectedType: Response.self)
        }
        return TransactionReceipt(
            gasUsed: gasUsed.description,
            blockNumber: blockNumber,
            contractAddress: contractAddress
        )
    }
}
