import UIKit

class SPPageControl: UIControl {

    var localNumberOfPages = NSInteger()//
    var localCurrentPage = NSInteger()//
    var localPointSize = CGSize()//
    var localPointSpace = CGFloat()//
    var localOtherColor = UIColor()//
    var localCurrentColor = UIColor()//
    var localOtherImage: UIImage?//
    var localCurrentImage: UIImage?//
    var localIsSquare = Bool()//
    var localCurrentWidthMultiple = CGFloat()//
    var localOtherBorderColor: UIColor?//layerColor
    var localOtherBorderWidth: CGFloat?//layer
    var localCurrentBorderColor: UIColor?//layerColor
    var localCurrentBorderWidth: CGFloat?//layer
    var clickIndex: ((_ result: NSInteger?) -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
  
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func initialize() {
        self.backgroundColor = UIColor.clear
        localNumberOfPages = 0//
        localCurrentPage = 0//
        localPointSize = CGSize.init(width: 6, height: 6)//6
        localPointSpace = 8//8
        localIsSquare = false//
        localOtherColor = UIColor.init(white: 1, alpha: 0.5)//，50%
        localCurrentColor = UIColor.white//
        localCurrentWidthMultiple = 1//，1
        creatPointView()//view
    }    

    var numberOfPages: NSInteger {
        set {
            if localNumberOfPages == newValue {
                return
            }
            localNumberOfPages = newValue
            creatPointView()
        }
        get {
            return self.localNumberOfPages
        }
    }

    var currentPage: NSInteger {
        set {
            if localCurrentPage == newValue {
                return
            }
            exchangeCurrentView(oldSelectedIndex: localCurrentPage, newSelectedIndex: newValue)
            localCurrentPage = newValue
        }
        get {
            return self.localCurrentPage
        }
    }
}
