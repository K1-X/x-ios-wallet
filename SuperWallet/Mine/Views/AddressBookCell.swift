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

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.contentView.backgroundColor = Colors.white
        bgView.backgroundColor = Colors.white
        let shadowView: UIView = UIView(frame: bgView.frame)
        self.contentView.addSubview(shadowView)
        shadowView.layer.shadowColor = Colors.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.shadowRadius = 1.0
        shadowView.layer.cornerRadius = 4.0
        shadowView.clipsToBounds = false
        shadowView.addSubview(bgView)

        bgView.layer.cornerRadius = 4.0
        bgView.layer.masksToBounds = true
        addressLabel.lineBreakMode = .byTruncatingMiddle
    }
}
