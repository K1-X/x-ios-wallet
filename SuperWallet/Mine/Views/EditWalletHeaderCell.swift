// Copyright DApps Platform Inc. All rights reserved.

import UIKit

class EditWalletHeaderCell: UITableViewCell {

    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var walletHeaderView: UIImageView!
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var walletAddressLabel: UILabel!
    @IBOutlet weak var walletNameTextLabel: UILabel!


    var viewModel: WalletAccountViewModel? {
        didSet {
            guard let model = viewModel else {
                return
            }
            walletHeaderView.image = model.image
            walletAddressLabel.text = model.currentWallet?.address.description
            amountLabel.text = model.balance
        }
    }    
 
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        walletHeaderView.layer.cornerRadius = walletHeaderView.frame.size.width/2.0
        walletHeaderView.layer.masksToBounds = true
        walletAddressLabel.textColor = Colors.white
        walletAddressLabel.lineBreakMode = .byTruncatingMiddle
        amountLabel.textColor = Colors.white
        bgView.backgroundColor = Colors.blue
        contentView.backgroundColor = Colors.white
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
