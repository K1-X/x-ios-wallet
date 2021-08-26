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

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        self.contentView.backgroundColor = Colors.white
        underLineView.backgroundColor = Colors.veryLightGray
        bgView.backgroundColor = Colors.white
        walletAddressLabel.lineBreakMode = .byTruncatingMiddle

        let shadowView: UIView = UIView(frame: bgView.frame)
        self.contentView.addSubview(shadowView)
        shadowView.layer.shadowColor = Colors.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.shadowRadius = 1.0
        shadowView.layer.cornerRadius = 4.0
        shadowView.clipsToBounds = false
        shadowView.addSubview(bgView)
        contentView.sendSubview(toBack: shadowView)

        bgView.layer.cornerRadius = 4.0
        bgView.layer.masksToBounds = true
    }
}
