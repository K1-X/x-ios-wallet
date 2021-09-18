// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
