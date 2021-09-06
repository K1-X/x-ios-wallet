// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustKeystore

struct ExportPrivateKeyViewModel {

    let privateKey: Data

    init(
        privateKey: Data
    ) {
        self.privateKey = privateKey
    }

    var headlineText: String {
        return NSLocalizedString("export.warning.private.key", value: "Export at your own risk!", comment: "")
    }    
}
