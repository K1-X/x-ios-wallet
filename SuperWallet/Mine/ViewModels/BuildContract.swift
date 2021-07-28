// Copyright DApps Platform Inc. All rights reserved.

import UIKit

class BuildContract: NSObject, Decodable {
    @objc dynamic var input: String = ""
    convenience init(
        input: String
        ) {
        self.init()
        self.input = input
    }

    private enum BuildContractCodingKeys: String, CodingKey {
        case input
    }

    convenience required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BuildContractCodingKeys.self)
        let input = try container.decode(String.self, forKey: .input)
        self.init(
            input: input
        )
    }
}
