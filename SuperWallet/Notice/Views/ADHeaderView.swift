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

    lazy var pageControl: SPPageControl = {
        let pageControl = SPPageControl()//PageControl
        pageControl.frame = CGRect.init(x: 0, y: scrollView.frame.maxY-20, width: self.frame.size.width, height: 20)
        pageControl.numberOfPages = self.imageUrls.count//
        pageControl.isSquare = true//
        pageControl.currentWidthMultiple = 1//3
        pageControl.currentColor = Colors.white
        pageControl.otherColor = Colors.lightGray
        pageControl.pointSize = CGSize.init(width: 30, height: 2)//size
        pageControl.clickPoint { (index) in//
            self.scrollView.setContentOffset(CGPoint.init(x: self.frame.size.width * CGFloat(index!), y: 0), animated: true)
        }
        return pageControl
    }()

    // MARK: - Public
    func resetCurrentPage(_ page: Int) {
        currentIndex = page
        pageControl.currentPage = page
        resetImageView()
        startTimer()
    }

    // MARK: - Init
    init(frame: CGRect, imageUrls: [String], tapAction action: @escaping(Int) -> Void) {
        self.imageUrls = imageUrls
        self.tapAction = action
        super.init(frame: frame)

        addImageView()
        addSubview(scrollView)
        addSubview(pageControl)
        startTimer()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetX = scrollView.contentOffset.x
        // 
        if contentOffsetX == 2 * scrollView.frame.width {// 
            currentIndex = getActualCurrentPage(calculatedPage: currentIndex + 1)
            resetImageView()
        } else if (contentOffsetX == 0) {// 
            currentIndex = getActualCurrentPage(calculatedPage: currentIndex - 1)
            resetImageView()
        }

        //  pageControl
        if contentOffsetX < scrollView.frame.width && contentOffsetX > 0 {
            if contentOffsetX <= scrollView.frame.width * 0.5 {
                pageControl.currentPage = getActualCurrentPage(calculatedPage: currentIndex - 1)
            } else if contentOffsetX > scrollView.frame.width * 0.5 {
                pageControl.currentPage = getActualCurrentPage(calculatedPage: currentIndex)
            }
        } else if contentOffsetX > scrollView.frame.width && contentOffsetX < scrollView.frame.width * 2 {
            if contentOffsetX >= scrollView.frame.width * 1.5 {
                pageControl.currentPage = getActualCurrentPage(calculatedPage: currentIndex + 1)
            } else if contentOffsetX < scrollView.frame.width * 1.5 {
                pageControl.currentPage = currentIndex
            }
        }

    }
}
