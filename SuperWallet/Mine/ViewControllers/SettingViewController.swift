// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import Eureka
import SnapKit
import PromiseKit
import MBProgressHUD

protocol SettingViewControllerDelegate: class {
    func didAction(action: SettingsAction, in viewController: SettingViewController)
    func didSelectChain()
}
