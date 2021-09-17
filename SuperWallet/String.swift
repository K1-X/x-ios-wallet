// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit

extension String {

    var hex: String {
        let data = self.data(using: .utf8)!
        return data.map { String(format: "%02x", $0) }.joined()
    }

    var hexEncoded: String {
        let data = self.data(using: .utf8)!
        return data.hexEncoded
    }

    var isHexEncoded: Bool {
        guard starts(with: "0x") else {
            return false
        }
        let regex = try! NSRegularExpression(pattern: "^0x[0-9A-Fa-f]*$")
        if regex.matches(in: self, range: NSRange(self.startIndex..., in: self)).isEmpty {
            return false
        }
        return true
    }    
}
