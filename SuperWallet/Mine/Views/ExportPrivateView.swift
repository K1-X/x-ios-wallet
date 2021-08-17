// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import SnapKit
import MBProgressHUD

class ExportPrivateView: UIView {

    lazy var backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.backgroundColor = Colors.black
        backgroundView.alpha = 0
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeTap)))
        return backgroundView
    }()

    lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.backgroundColor = Colors.white
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
        return contentView
    }()
    
}
