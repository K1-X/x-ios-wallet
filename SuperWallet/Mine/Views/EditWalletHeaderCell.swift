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
}
