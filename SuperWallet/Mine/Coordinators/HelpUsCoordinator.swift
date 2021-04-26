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
   
    init(
        navigationController: NavigationController = NavigationController(),
        appTracker: AppTracker = AppTracker()
    ) {
        self.navigationController = navigationController
        self.navigationController.modalPresentationStyle = .formSheet
        self.appTracker = appTracker
    }

    func start() {
        switch appTracker.launchCountForCurrentBuild {
        case 6 where !appTracker.completedRating:
            break
//            rateUs()
        case 12 where !appTracker.completedSharing:
            presentWellDone()
        default: break
        }
    }

}
