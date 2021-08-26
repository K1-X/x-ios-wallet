// Copyright DApps Platform Inc. All rights reserved.

import UIKit

class WalletManagerCell: UITableViewCell {

    @IBOutlet weak var bgView: UIImageView!
    @IBOutlet weak var walletHeaderView: UIImageView!
    @IBOutlet weak var walletNameLabel: UILabel!
    @IBOutlet weak var walletAddressLabel: UILabel!
    @IBOutlet weak var underLineView: UIView!
    @IBOutlet weak var walletBlockLabel: UILabel!
    @IBOutlet weak var amountLabel: UILabel!    

    var viewModel: WalletAccountViewModel? {
        didSet {
            guard let model = viewModel else {
                return
            }
            walletHeaderView.image = model.image
            walletNameLabel.text = model.title
            walletAddressLabel.text = model.wallet.address.description
            amountLabel.text = model.balance
        }
    }
}
