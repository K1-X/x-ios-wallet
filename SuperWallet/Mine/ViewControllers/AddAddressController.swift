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
}
