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

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollView.setContentOffset(CGPoint(x: self.frame.width, y: 0), animated: true)
        startTimer()
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer?.invalidate()
        timer = nil
    }

    // MARK: - Action
    @objc fileprivate func cycleViewDidClick(gesture: UITapGestureRecognizer) {
        print("\(currentIndex)")
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        imageView.kf.setImage(with: URL(string: imageUrls[currentIndex])!)
        tapAction(currentIndex)
    }

    @objc fileprivate func autoScroll() {
        if imageUrls.count < 2 {
            return
        }
        scrollView.setContentOffset(CGPoint(x: self.frame.width * 2, y: 0), animated: true)
    }

    func startTimer() {
        guard !imageUrls.isEmpty else { return }

        if let myTimer = timer {
            myTimer.invalidate()
            timer = nil
        }
        timer = Timer.scheduledTimer(timeInterval: self.timeInterval, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: RunLoopMode.commonModes)
    }

    func invalidateTimer() {
        timer?.invalidate()
        timer = nil
    }

    fileprivate func addImageView() {
        var x: CGFloat = 0
        var pageIndex: NSInteger = self.imageUrls.count - 1
        for index in 0..<3 {
            let imgNode = UIImageView()
            x = CGFloat(index) * frame.width
            imgNode.frame = CGRect(x: x, y: 0, width: frame.width, height: frame.height)
            imgNode.kf.setImage(with: URL(string: imageUrls.isEmpty ? "":(imageUrls[pageIndex]))!)
            imgNode.contentMode = .scaleAspectFill
            imgNode.clipsToBounds = true

            let gesture = UITapGestureRecognizer(target: self, action: #selector(cycleViewDidClick(gesture:)))
            imgNode.addGestureRecognizer(gesture)
            imgNode.isUserInteractionEnabled = true
            imageArray.append(imgNode)
            scrollView.addSubview(imgNode)

            if imageUrls.count == 1 {
                pageIndex = 0
                scrollView.isScrollEnabled = false
            } else {
                pageIndex = index == 0 ? 0 : 1
            }
        }
    }
    fileprivate func resetImageView() {
        let preIndex: NSInteger = getActualCurrentPage(calculatedPage: currentIndex - 1)
        let nextIndex: NSInteger = getActualCurrentPage(calculatedPage: currentIndex + 1)
        if imageUrls.isEmpty {
            return
        }
        imageArray[0].kf.setImage(with: URL(string: imageUrls[preIndex])!)
        imageArray[1].kf.setImage(with: URL(string: imageUrls[preIndex])!)
        imageArray[2].kf.setImage(with: URL(string: imageUrls[preIndex])!)
        scrollView.contentOffset = CGPoint(x: self.frame.width, y: 0)// setcontentOffset:animate，bug
    }
    /// 
    ///
    /// - Parameter page: +1-1
    /// - Returns: 
    fileprivate func getActualCurrentPage(calculatedPage page: NSInteger) -> NSInteger {
        if page == imageUrls.count {
            return 0
        } else if page == -1 {
            return imageUrls.count - 1
        } else {
            return page
        }
    }
}
