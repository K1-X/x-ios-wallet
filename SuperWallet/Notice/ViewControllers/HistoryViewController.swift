// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import StatefulViewController

protocol HistoryViewControllerDelegate: class {
    func didSelect(history: History, in controller: HistoryViewController)
}

final class HistoryViewController: UIViewController {

    let store: HistoryStore
    let tableView = UITableView(frame: .zero, style: .plain)
    lazy var viewModel: HistoriesViewModel = {
        return HistoriesViewModel(store: store)
    }()
}
