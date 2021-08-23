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

}
