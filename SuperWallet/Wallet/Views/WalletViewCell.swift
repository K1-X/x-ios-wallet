// Copyright DApps Platform Inc. All rights reserved.

import TrustCore
import UIKit

protocol WalletViewCellDelegate: class {
    func didPress(viewModel: WalletAccountViewModel, in cell: WalletViewCell)
}

final class WalletViewCell: UITableViewCell {

    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var glassesImageView: UIImageView!
    @IBOutlet weak var walletTypeImageView: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    @IBOutlet weak var identiconImageView: TokenImageView!
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var balance: UILabel!

}


