// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import StatefulViewController

protocol HistoryViewControllerDelegate: class {
    func didSelect(history: History, in controller: HistoryViewController)
}

