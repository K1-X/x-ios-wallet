// Copyright DApps Platform Inc. All rights reserved.

import Foundation

struct SelectCoinsViewModel {

    let elements: [CoinViewModel]

    init(elements: [CoinViewModel]) {
        self.elements = elements
    }

    var title: String {
        return R.string.localizable.importWalletImportButtonTitle()
    }
    
}
