import UIKit
import Kingfisher

class ADHeaderView: UIView, UIScrollViewDelegate {
    var timeInterval: TimeInterval = 4

    private var imageUrls: [String] = [String]()
    private var imageArray: [UIImageView] = [UIImageView]()
    private var tapAction: (Int) -> Void
    private var currentIndex: Int = 0
    private weak var timer: Timer?    

}
