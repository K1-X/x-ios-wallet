// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit
import Rswift

enum URLServiceProvider {
    case twitter
    case telegram
    case facebook
    case discord
    case helpCenter
    case sourceCode
    case privacyPolicy
    case termsOfService
    case infura
    case dappsOpenSea    

    var title: String {
        switch self {
        case .twitter: return "Twitter"
        case .telegram: return "Telegram Group"
        case .facebook: return "Facebook"
        case .discord: return "Discord"
        case .helpCenter: return R.string.localizable.settingsHelpCenterTitle()
        case .sourceCode: return R.string.localizable.settingsSourceCodeButtonTitle()
        case .privacyPolicy: return R.string.localizable.settingsPrivacyTitle()
        case .termsOfService: return R.string.localizable.settingsTermsOfServiceButtonTitle()
        case .infura: return R.string.localizable.infura()
        case .dappsOpenSea: return R.string.localizable.openSea()
        }
    }
}
