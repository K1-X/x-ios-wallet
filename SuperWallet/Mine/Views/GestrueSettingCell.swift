// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import SnapKit

protocol GestrueSettingCellDelegate: class {
    func didOpenGestureSetting(cell: GestrueSettingCell, isOn: Bool)
}

class GestrueSettingCell: UITableViewCell {

     @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var enterarrow: UIImageView!
    @IBOutlet weak var openGesture: UISwitch!    

    lazy var underLineView: UIView = {
        let underLineView = UIView()
        underLineView.backgroundColor = Colors.veryLightGray
        return underLineView
    }()
    weak var delegate: GestrueSettingCellDelegate?
    var isOpenGestureSetting = false
}
