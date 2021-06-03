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

    var localURL: URL? {
        switch self {
        case .twitter:
            return URL(string: "twitter://user?screen_name=\(Constants.twitterUsername)")!
        case .telegram:
            return URL(string: "tg://resolve?domain=\(preferredTelegramUsername())")
        case .facebook:
            return URL(string: "fb://profile?id=\(Constants.facebookUsername)")
        case .discord: return nil
        case .helpCenter: return nil
        case .sourceCode: return nil
        case .privacyPolicy: return nil
        case .termsOfService: return nil
        case .infura: return nil
        case .dappsOpenSea: return nil
        }
    }
}
