// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import SnapKit

class ImportWalletHeaderView: UIView {

    lazy var noticeLabel: UILabel = {
        let noticeLabel = UILabel()
        noticeLabel.numberOfLines = 0
        noticeLabel.textColor = Colors.gray
        noticeLabel.font = UIFont.systemFont(ofSize: 15)
        noticeLabel.text = "KeyStore。KeyStore，"
        return noticeLabel
    }()

    lazy var keystoreView: UITextView = {
        let keystoreView = UITextView()
        keystoreView.tintColor = Colors.blue
        keystoreView.layer.shadowColor = Colors.black.cgColor
        keystoreView.layer.shadowOffset = CGSize(width: 0, height: 0)
        keystoreView.layer.shadowOpacity = 0.8
        keystoreView.layer.shadowRadius = 2.0
        return keystoreView
    }()    
}
