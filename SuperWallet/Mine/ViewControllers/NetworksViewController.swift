// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit
import Eureka

final class NetworksViewController: FormViewController {

    lazy var addButton: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(addNetwork))
    }()
   
}
