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

    weak var delegate: HistoryViewControllerDelegate?

    init(store: HistoryStore) {
        self.store = store

        super.init(nibName: nil, bundle: nil)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 60
        tableView.register(UINib(resource: R.nib.bookmarkViewCell), forCellReuseIdentifier: R.nib.bookmarkViewCell.name)
        view.addSubview(tableView)
        emptyView = EmptyView(title: NSLocalizedString("history.noHistory.label.title", value: "No history yet!", comment: ""))

        NSLayoutConstraint.activate([
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupInitialViewState()

        fetch()
    }

    func fetch() {
        tableView.reloadData()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
