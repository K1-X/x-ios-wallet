// Copyright DApps Platform Inc. All rights reserved.

import Foundation

public struct Constants {
    public static let keychainKeyPrefix = "superwallet"
    public static let keychainTestsKeyPrefix = "superwallet-tests"
 
    // social
    public static let website = "https://superwalletapp.com"
    public static let twitterUsername = "superwalletapp"
    public static let defaultTelegramUsername = "superwallet"
    public static let facebookUsername = "superwalletapp"


   public static var localizedTelegramUsernames = ["ru": "superwallet_ru", "vi": "superwallet_vn", "es": "superwallet_es", "zh": "superwallet_cn", "ja": "superwallet_jp", "de": "superwallet_de", "fr": "superwallet_fr"]

    // support
    public static let supportEmail = "support@superwalletapp.com"

    public static let dappsBrowserURL = "https://dapps.superwalletapp.com/"
    public static let dappsOpenSea = "https://opensea.io"
    public static let dappsRinkebyOpenSea = "https://rinkeby.opensea.io"

    public static let images = "https://superwalletapp.com/images"

    public static let superWalletAPI = URL(string: "http://116.62.160.218:8080")!
}

public struct UnitConfiguration {
    public static let gasPriceUnit: EthereumUnit = .gwei
    public static let gasFeeUnit: EthereumUnit = .ether
}
