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

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpUI()
    }

    func setUpUI() {
        scrollView.backgroundColor = Colors.veryLightGray
        scanTitle.textColor = Colors.blue
        scanTitle.text = R.string.localizable.exportKeyStoreScanTitle()
        scanNotice.textColor = Colors.lightGray
        scanNotice.text = R.string.localizable.exportKeyStoreScanNotice()
        safetyTitle.textColor = Colors.blue
        safetyTitle.text = R.string.localizable.exportKeyStoreSafetyTitle()
        safetyNotice.textColor = Colors.lightGray
        safetyNotice.text = R.string.localizable.exportKeyStoreSafetyNotice()

        scanNoticeHConstraint.constant = (scanNotice.text?.textHeight(font: scanNotice.font, width: scanNotice.frame.size.width))!
        safetyNoticeHConstraint.constant = (safetyNotice.text?.textHeight(font: safetyNotice.font, width: safetyNotice.frame.size.width))!

        DispatchQueue.global(qos: .userInteractive).async {
            let image = QRGenerator.generate(from: self.keystoreStr)
            DispatchQueue.main.async {
                self.codeImageView.image = image
            }
        }
    }
}
