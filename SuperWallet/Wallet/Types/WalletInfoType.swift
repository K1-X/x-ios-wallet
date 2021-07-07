// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustKeystore
import UIKit
import TrustCore

enum WalletInfoType {

    case exportRecoveryPhrase(Wallet)
    case exportPrivateKey(Account)
    case exportKeystore(Account)
    case copyAddress(Address)    

    var title: String {
        switch self {
        case .exportRecoveryPhrase:
            return NSLocalizedString("wallet.info.exportBackupPhrase", value: "Show Backup Phrase", comment: "")
        case .exportKeystore:
            return NSLocalizedString("wallets.backup.alertSheet.title", value: "Backup Keystore", comment: "")
        case .exportPrivateKey:
            return NSLocalizedString("wallets.export.alertSheet.title", value: "Export Private Key", comment: "")
        case .copyAddress:
            return R.string.localizable.copyAddress()
        }
    }
}
