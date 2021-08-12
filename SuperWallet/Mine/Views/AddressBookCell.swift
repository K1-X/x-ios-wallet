// Copyright DApps Platform Inc. All rights reserved.

import UIKit

class AddressBookCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var addressNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var remarkLabel: UILabel!
    
    func configure(addressBook: AddressBook) {
        headerImageView.image = R.image.sct_logo()
        addressNameLabel.text = addressBook.addressName
        addressLabel.text = addressBook.address
        remarkLabel.text = addressBook.remark
    }
}
