// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit

struct InCoordinatorViewModel {

    let config: Config
    let preferences: PreferencesController

    init(
        config: Config,
        preferences: PreferencesController = PreferencesController()
    ) {
        self.config = config
        self.preferences = preferences
    }

    var imageInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    }

    var walletBarItem: UITabBarItem {
        let image: UIImage = R.image.ic_index_checked()!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        return UITabBarItem(
            title: "",
            image: R.image.ic_index_normal(),
            selectedImage: image
        )
    }

    var transactionsBarItem: UITabBarItem {
        let image: UIImage = R.image.ic_finance_check()!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        return UITabBarItem(
            title: "",
            image: R.image.ic_finance_normal(),
            selectedImage: image
        )
    }

    var browserBarItem: UITabBarItem {
        let image: UIImage = R.image.ic_discovery_checked()!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        return UITabBarItem(
            title: "",
            image: R.image.ic_discovery_normal(),
            selectedImage: image
        )
    }

    var mineBarItem: UITabBarItem {
        let image: UIImage = R.image.ic_mine_checked()!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        return UITabBarItem(
            title: "",
            image: R.image.ic_mine_normal(),
            selectedImage: image
        )
    }
}
