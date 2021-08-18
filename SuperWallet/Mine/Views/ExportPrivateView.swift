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

    lazy var privateLabel: TextInsetLabel = {
        let privateLabel = TextInsetLabel()
        privateLabel.font = UIFont.systemFont(ofSize: 14)
        privateLabel.textColor = Colors.black
        privateLabel.textAlignment = .left
        privateLabel.numberOfLines = 0
        privateLabel.edgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 5)
        privateLabel.backgroundColor = Colors.lightGray
        return privateLabel
    }()

    lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.setImage(R.image.cancel(), for: .normal)
        closeButton.addTarget(self, action: #selector(closeTap), for: .touchUpInside)
        return closeButton
    }()

    lazy var copyButton: UIButton = {
        let copyButton = UIButton()
        copyButton.setTitle(R.string.localizable.exportPrivateAlertCopy(), for: .normal)
        copyButton.backgroundColor = Colors.blue
        copyButton.setTitleColor(Colors.white, for: .normal)
        copyButton.layer.cornerRadius = copyButton.frame.size.height / 2.0
        copyButton.layer.masksToBounds = true
        copyButton.addTarget(self, action: #selector(copyPrivate), for: .touchUpInside)
        return copyButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backgroundView)
        addSubview(contentView)

        contentView.addSubview(titleLabel)
        contentView.addSubview(noticeLabel)
        contentView.addSubview(privateLabel)
        contentView.addSubview(closeButton)
        contentView.addSubview(copyButton)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        contentView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 300, height: 340))
        }
        closeButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.trailing.equalToSuperview().offset(-edgeWidth)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 120, height: 25))
        }
        noticeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(edgeWidth)
            make.trailing.equalToSuperview().offset(-edgeWidth)
            make.height.equalTo(100)
        }
        privateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(noticeLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(edgeWidth)
            make.trailing.equalToSuperview().offset(-edgeWidth)
            make.height.equalTo(100)
        }
        copyButton.snp.makeConstraints { (make) in
            make.top.equalTo(privateLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(edgeWidth)
            make.trailing.equalToSuperview().offset(-edgeWidth)
            make.height.equalTo(50)
        }
    }

    public func show() {
        let keyWindow = UIApplication.shared.keyWindow
        keyWindow?.addSubview(self)
        self.frame = keyWindow!.bounds
        self.isHidden = false
        UIView.animate(withDuration: 0.2) {
            self.backgroundView.alpha = 0.5
        }
//        self.popView()
    }

    func close(complete:@escaping () -> Void) {
        UIView.animate(withDuration: 0.2, animations: {
            self.backgroundView.alpha = 0
        }) { _ in
            self.isHidden = true
            complete()
        }
    }

    public func dismiss() {
        self.dissmiss {}
    }

    func dissmiss(complete:@escaping () -> Void) {
//        self.dismissView()
        self.close {
            self.removeFromSuperview()
        }
    }

    @objc func closeTap() {
        self.dismiss()
    }

    @objc func copyPrivate() {
        if  self.privateLabel.text!.isEmpty {
            self.dismiss()
            return
        }
        let pasteboard = UIPasteboard.general
        pasteboard.string = self.privateLabel.text
        let hud = MBProgressHUD.showAdded(to: self, animated: true)
        hud.mode = .text
        hud.label.text = ""
        hud.hide(animated: true, afterDelay: 1.5)
        self.dismiss()
    }

    func popView() {
        let popAnimation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform")
        popAnimation.duration = 0.35
        popAnimation.values = [[NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 0.7, 0.7, 1.0))],
                               [NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 1.0, 1.1, 1.0))],
                               [NSValue(caTransform3D: CATransform3DIdentity)]]
        popAnimation.keyTimes = [0.0, 0.75, 1.0]
        popAnimation.timingFunctions = [CAMediaTimingFunction(name: "easeOut"),
                                        CAMediaTimingFunction(name: "easeOut"),
                                        CAMediaTimingFunction(name: "easeOut")]
        popAnimation.isRemovedOnCompletion = true
        popAnimation.isCumulative = false
        self.layer.add(popAnimation, forKey: nil)
    }

    func dismissView() {
        let hideAnimation: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: "transform")
        hideAnimation.duration = 0.25
        hideAnimation.values = [[NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 1.0))],
                               [NSValue(caTransform3D: CATransform3DScale(CATransform3DIdentity, 0.5, 0.5, 0.5))],
                               [NSValue(caTransform3D: CATransform3DIdentity)]]
        hideAnimation.keyTimes = [0.0, 0.0, 0.0]
        hideAnimation.timingFunctions = [CAMediaTimingFunction(name: "easeOut"),
                                        CAMediaTimingFunction(name: "easeOut"),
                                        CAMediaTimingFunction(name: "easeOut")]
        hideAnimation.isRemovedOnCompletion = true
        hideAnimation.isCumulative = false
        self.layer.add(hideAnimation, forKey: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
