// Copyright DApps Platform Inc. All rights reserved.
import Foundation
import UIKit
import StoreKit

final class HelpUsCoordinator: Coordinator {

	let navigationController: NavigationController
    let appTracker: AppTracker
    var coordinators: [Coordinator] = []
    
    private let viewModel = HelpUsViewModel()
    private lazy var wellDoneController: WellDoneViewController = {
        let controller = WellDoneViewController()
        controller.navigationItem.title = viewModel.title
        controller.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismiss))
        controller.delegate = self
        return controller
    }()
}
