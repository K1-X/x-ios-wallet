// Copyright DApps Platform Inc. All rights reserved.
import UIKit

enum WellDoneAction {
    case other
}


protocol WellDoneViewControllerDelegate: class {
    func didPress(action: WellDoneAction, sender: UIView, in viewController: WellDoneViewController)
}

