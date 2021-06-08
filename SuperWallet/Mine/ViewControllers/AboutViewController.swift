import Foundation

import UIKit
import Eureka
import MessageUI

protocol AboutViewControllerDelegate: class {
    func didPressURL(_ url: URL, in controller: AboutViewController)
}

final class AboutViewController: FormViewController {

    let viewModel = AboutViewModel()
    weak var delegate: AboutViewControllerDelegate?

    init() {
        super.init(nibName: nil, bundle: nil)
    }

}
