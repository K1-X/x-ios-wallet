import UIKit

class MineHeaderView: UIView {

    lazy var bgImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = R.image.personal_center_bg()
        return imageView
    }()    

}
