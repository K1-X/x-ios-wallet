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
    
}
