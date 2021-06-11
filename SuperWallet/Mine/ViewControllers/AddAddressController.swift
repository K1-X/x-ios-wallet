// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import SnapKit
import MBProgressHUD
import TrustCore

class AddAddressController: UIViewController {

    let store: AddressBookStorage

    lazy var addressNameTextField: UITextField = {
        let addressName = UITextField()
        addressName.placeholder = ""
        addressName.delegate = self
        addressName.tintColor = Colors.blue
        return addressName
    }()


    lazy var addressNameUnderLine: UIView = {
        let addressNameUnderLine = UIView()
        addressNameUnderLine.backgroundColor = Colors.veryLightGray
        return addressNameUnderLine
    }()

    lazy var remarkTextField: UITextField = {
        let remarkTextField = UITextField()
        remarkTextField.placeholder = "（）"
        remarkTextField.delegate = self
        remarkTextField.tintColor = Colors.blue
        return remarkTextField
    }()    

    lazy var remarkUnderLine: UIView = {
        let remarkUnderLine = UIView()
        remarkUnderLine.backgroundColor = Colors.veryLightGray
        return remarkUnderLine
    }()

    lazy var tokenName: UILabel = {
        let tokenName = UILabel()
        tokenName.text = "SCT:"
        tokenName.textAlignment = .center
        tokenName.font = UIFont.systemFont(ofSize: 16)
        return tokenName
    }()

    lazy var addressvLine: UIView = {
        let addressvLine = UIView()
        addressvLine.backgroundColor = Colors.veryLightGray
        return addressvLine
    }()
    lazy var addressTextField: UITextField = {
        let addressTextField = UITextField()
        let attributedString:NSAttributedString =  NSAttributedString(string: "", attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 12)])
        addressTextField.attributedPlaceholder = attributedString
        addressTextField.delegate = self
        addressTextField.tintColor = Colors.blue
        return addressTextField
    }()

    lazy var addresshLine: UIView = {
        let addresshLine = UIView()
        addresshLine.backgroundColor = Colors.veryLightGray
        return addresshLine
    }()
    lazy var scanButton: UIButton = {
        let scanButton = UIButton(type: .custom)
        scanButton.setImage(R.image.qr_code_scan(), for: .normal)
        scanButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 36, bottom: 0, right: 0)
        scanButton.imageView?.contentMode = .scaleAspectFill
        scanButton.addTarget(self, action: #selector(scanAddressCode), for: .touchUpInside)
        return scanButton
    }()

    lazy var saveButton: UIButton = {
        let saveButton = UIButton(type: .custom)
        saveButton.setTitle(R.string.localizable.mineAddressBookAddAddressSave(), for: .normal)
        saveButton.setBackgroundColor(Colors.blue, forState: .normal)
        saveButton.layer.cornerRadius = 24
        saveButton.layer.masksToBounds = true
        saveButton.addTarget(self, action: #selector(saveAddress), for: .touchUpInside)
        return saveButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.white
        title = R.string.localizable.mineAddressBookAddAddressTitle()
        view.addSubview(addressNameTextField)
        view.addSubview(addressNameUnderLine)
        view.addSubview(remarkTextField)
        view.addSubview(remarkUnderLine)
        view.addSubview(tokenName)
        view.addSubview(addressvLine)
        view.addSubview(addressTextField)
        view.addSubview(addresshLine)
        view.addSubview(scanButton)
        view.addSubview(saveButton)
        addressTextField.font = UIFont.systemFont(ofSize: 13)

        addressNameTextField.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(currentNaviHeight+20)
            make.leading.equalToSuperview().offset(edgeWidth)
            make.trailing.equalToSuperview().offset(-edgeWidth)
            make.height.equalTo(60)
        }
        addressNameUnderLine.snp.makeConstraints { (make) in
            make.top.equalTo(addressNameTextField.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(edgeWidth)
            make.trailing.equalToSuperview().offset(-edgeWidth)
            make.height.equalTo(0.5)
        }
        remarkTextField.snp.makeConstraints { (make) in
            make.top.equalTo(addressNameUnderLine.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(edgeWidth)
            make.trailing.equalToSuperview().offset(-edgeWidth)
            make.height.equalTo(60)
        }
        remarkUnderLine.snp.makeConstraints { (make) in
            make.top.equalTo(remarkTextField.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(edgeWidth)
            make.trailing.equalToSuperview().offset(-edgeWidth)
            make.height.equalTo(0.5)
        }
        addresshLine.snp.makeConstraints { (make) in
            make.top.equalTo(remarkUnderLine.snp.bottom).offset(120)
            make.leading.equalToSuperview().offset(edgeWidth)
            make.trailing.equalToSuperview().offset(-edgeWidth)
            make.height.equalTo(0.5)
        }
        addressvLine.snp.makeConstraints { (make) in
            make.bottom.equalTo(addresshLine.snp.top)
            make.leading.equalTo(tokenName.snp.trailing).offset(2)
            make.width.equalTo(0.5)
            make.height.equalTo(90)
        }
        tokenName.snp.makeConstraints { (make) in
            make.bottom.equalTo(addresshLine.snp.top).offset(-2)
            make.leading.equalToSuperview().offset(edgeWidth)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        scanButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(addresshLine.snp.top).offset(-2)
            make.trailing.equalToSuperview().offset(-edgeWidth)
            make.height.equalTo(60)
            make.width.equalTo(60)
        }
        addressTextField.snp.makeConstraints { (make) in
            make.bottom.equalTo(addresshLine.snp.top).offset(-2)
            make.leading.equalTo(addressvLine.snp.trailing).offset(10)
            make.trailing.equalTo(scanButton.snp.leading).offset(-2)
            make.height.equalTo(60)
        }
        saveButton.snp.makeConstraints { (make) in
            make.top.equalTo(addresshLine.snp.bottom).offset(120)
            make.leading.equalToSuperview().offset(edgeWidth)
            make.trailing.equalToSuperview().offset(-edgeWidth)
            make.height.equalTo(48)
        }
    }
}
