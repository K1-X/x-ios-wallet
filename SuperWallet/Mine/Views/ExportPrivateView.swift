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

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = R.string.localizable.exportPrivateAlertTitle()
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.textColor = Colors.black
        titleLabel.textAlignment = .center
        return titleLabel
    }()

    lazy var noticeLabel: TextInsetLabel = {
        let noticeLabel = TextInsetLabel()
        noticeLabel.text = R.string.localizable.exportPrivateAlertNotice()
        noticeLabel.font = UIFont.systemFont(ofSize: 14)
        noticeLabel.textColor = Colors.red
        noticeLabel.textAlignment = .left
        noticeLabel.numberOfLines = 0
        noticeLabel.edgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 5)
        noticeLabel.backgroundColor = Colors.veryLightOrange
        noticeLabel.layer.borderColor = Colors.red.cgColor
        noticeLabel.layer.borderWidth = 1
        return noticeLabel
    }()    
}
