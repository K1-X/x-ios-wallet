import UIKit
import Kingfisher

class ADHeaderView: UIView, UIScrollViewDelegate {
    var timeInterval: TimeInterval = 4

    private var imageUrls: [String] = [String]()
    private var imageArray: [UIImageView] = [UIImageView]()
    private var tapAction: (Int) -> Void
    private var currentIndex: Int = 0
    private weak var timer: Timer?    


    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.frame = self.bounds
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.decelerationRate = 1
        scrollView.setContentOffset(CGPoint(x: self.frame.width, y: 0), animated: false)
        scrollView.contentSize = CGSize(width: self.frame.size.width * 3.0, height: 0)
        return scrollView
    }()
}
