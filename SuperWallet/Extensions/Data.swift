// Copyright DApps Platform Inc. All rights reserved.

import Foundation

extension Data {
    var hex: String {
        return map { String(format: "%02hhx", $0) }.joined()
    }

    var hexEncoded: String {
        return "0x" + self.hex
    }

    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }    

    func data(from hexStr: String) -> Data {
        let bytes = self.bytes(from: hexStr)
        return Data(bytes: bytes)
    }

    // 16 [UInt8]
    //  Data
    // Data(bytes: Array<UInt8>)
    func bytes(from hexStr: String) -> [UInt8] {
        assert(hexStr.count % 2 == 0, "，8")
        var bytes = [UInt8]()
        var sum = 0
        //  utf8 
        let intRange = 48...57
        //  a~f  utf8 
        let lowercaseRange = 97...102
        //  A~F  utf8 
        let uppercasedRange = 65...70
        for (index, c) in hexStr.utf8CString.enumerated() {
            var intC = Int(c.byteSwapped)
            if intC == 0 {
                break
            } else if intRange.contains(intC) {
                intC -= 48
            } else if lowercaseRange.contains(intC) {
                intC -= 87
            } else if uppercasedRange.contains(intC) {
                intC -= 55
            } else {
                assertionFailure("，0~9，a~f，A~F")
            }
            sum = sum * 16 + intC
            // 8，
            if index % 2 != 0 {
                bytes.append(UInt8(sum))
                sum = 0
            }
        }
        return bytes
    }
}
