import Foundation

import UIKit
import Eureka
import MessageUI

protocol AboutViewControllerDelegate: class {
    func didPressURL(_ url: URL, in controller: AboutViewController)
}

