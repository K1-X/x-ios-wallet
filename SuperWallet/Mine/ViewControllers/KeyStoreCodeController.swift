// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import CoreImage

class KeyStoreCodeController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scanTitle: UILabel!
    @IBOutlet weak var scanNotice: UILabel!
    @IBOutlet weak var safetyTitle: UILabel!
    @IBOutlet weak var safetyNotice: UILabel!
    @IBOutlet weak var codeImageView: UIImageView!
    

    @IBOutlet weak var scanNoticeHConstraint: NSLayoutConstraint!
    @IBOutlet weak var safetyNoticeHConstraint: NSLayoutConstraint!

    let keystoreStr: String
    init(keystoreStr: String) {
        self.keystoreStr = keystoreStr
        super.init(nibName: "KeyStoreCodeController", bundle: nil)
    }
}
