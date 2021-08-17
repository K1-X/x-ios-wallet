// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import TrustCore

struct ImportWalletViewModel {

    private let coin: CoinViewModel
    init(
        coin: Coin
    ) {
        self.coin = CoinViewModel(coin: coin)
    }
    var title: String {
        return R.string.localizable.importWalletImportButtonTitle() + " " + coin.name
    }
    var keystorePlaceholder: String {
        return R.string.localizable.keystoreJSON()
    }
    
}
