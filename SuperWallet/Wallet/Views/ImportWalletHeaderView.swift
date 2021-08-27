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
    
}
