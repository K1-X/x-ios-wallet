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
    
}
