import UIKit

class MineHeaderView: UIView {

    lazy var bgImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = R.image.personal_center_bg()
        return imageView
    }()    

    lazy var headerButton: UIButton = {
        let headerButton = UIButton()
        headerButton.translatesAutoresizingMaskIntoConstraints = false
        headerButton.setBackgroundImage(R.image.ic_mine_checked(), for: .normal)
        return headerButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(headerButton)

        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        headerButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(80)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 80))
        }

    }
}
