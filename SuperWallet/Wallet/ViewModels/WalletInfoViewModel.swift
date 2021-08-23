// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustKeystore

struct FormSection {
    let footer: String?
    let header: String?
    let rows: [WalletInfoType]

    init(footer: String? = .none, header: String? = .none, rows: [WalletInfoType]) {
        self.footer = footer
        self.header = header
        self.rows = rows
    }
}
