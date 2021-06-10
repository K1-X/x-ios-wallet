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
}
