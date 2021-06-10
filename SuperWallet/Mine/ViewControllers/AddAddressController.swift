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
}
