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

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(noticeLabel)
        addSubview(keystoreView)
        let noticeH = (noticeLabel.text?.textHeight(font: noticeLabel.font, width: frame.size.width-2*edgeWidth))!+5.0
        self.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 50+noticeH+80+120)
        noticeLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(50)
            make.leading.equalToSuperview().offset(edgeWidth)
            make.trailing.equalToSuperview().offset(-edgeWidth)
            make.height.equalTo(noticeH)
        }
        keystoreView.snp.makeConstraints { (make) in
            make.top.equalTo(noticeLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(25)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(120)
        }
    }
}
