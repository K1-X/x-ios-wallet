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

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textColor = Colors.black
        detailLabel.textColor = Colors.lightGray
        contentView.addSubview(underLineView)
        underLineView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview()
            make.height.equalTo(1)
        }
    }

    @objc func openGesture(openGestureSwitch: UISwitch) {
        delegate?.didOpenGestureSetting(cell: self, isOn: openGestureSwitch.isOn)
    }

    public func confgure(title: String, detail: String, indexPath: IndexPath) {
        titleLabel.text = title

        if indexPath.section == 0 {
            openGesture.isHidden = false
            enterarrow.isHidden = true
            detailLabel.isHidden = true
            underLineView.isHidden = false
            openGesture.addTarget(self, action: #selector(openGesture(openGestureSwitch:)), for: .valueChanged)
            underLineView.snp.updateConstraints { (make) in
                make.leading.equalToSuperview().offset(0)
            }
        } else {
            openGesture.isHidden = true
            enterarrow.isHidden = false
            detailLabel.isHidden = false
        }

        if !detail.isEmpty && indexPath.section != 0 {
            enterarrow.isHidden = true
            detailLabel.text = detail
        } else {
            detailLabel.isHidden = true
        }

        if indexPath.section == 3 {
            underLineView.isHidden = true
        }

        if indexPath.section == 1 {
            underLineView.isHidden = false
            underLineView.snp.updateConstraints { (make) in
                make.leading.equalToSuperview().offset(edgeWidth)
            }
        }

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
