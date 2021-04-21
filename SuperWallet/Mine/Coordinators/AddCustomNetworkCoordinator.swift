// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit

protocol AddCustomNetworkCoordinatorDelegate: class {
    func didAddNetwork(network: CustomRPC, in coordinator: AddCustomNetworkCoordinator)
    func didCancel(in coordinator: AddCustomNetworkCoordinator)
}


final class AddCustomNetworkCoordinator: Coordinator {
    let navigationController: NavigationController
    var coordinators: [Coordinator] = []
    weak var delegate: AddCustomNetworkCoordinatorDelegate?

   lazy var addNetworkItem: UIBarButtonItem = {
        return UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNetwork)
        )
    }()
    
   lazy var addCustomNetworkController: AddCustomNetworkViewController = {
        let controller = AddCustomNetworkViewController()
        controller.navigationItem.rightBarButtonItem = addNetworkItem
        return controller
    }()

 
}
