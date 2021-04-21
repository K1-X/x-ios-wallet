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

}
