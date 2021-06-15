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

    var pointSize: CGSize {
        set {
            if localPointSize != newValue {
                localPointSize = newValue
                creatPointView()
            }
        }
        get {
            return self.localPointSize
        }
    }

    var pointSpace: CGFloat {
        set {
            if localPointSpace != newValue {
                localPointSpace = newValue
                creatPointView()
            }
        }
        get {
            return self.localPointSpace
        }
    }

    var otherColor: UIColor {
        set {
            if localOtherColor != newValue {
                localOtherColor = newValue
                creatPointView()
            }
        }
        get {
            return self.localOtherColor
        }
    }

    var currentColor: UIColor {
        set {
            if localCurrentColor != newValue {
                localCurrentColor = newValue
                creatPointView()
            }
        }
        get {
            return self.localCurrentColor
        }
    }

    var otherImage: UIImage {
        set {
            if localOtherImage != newValue {
                localOtherImage = newValue
                creatPointView()
            }
        }
        get {
            return self.localOtherImage!
        }
    }

    var currentImage: UIImage {
        set {
            if localCurrentImage != newValue {
                localCurrentImage = newValue
                creatPointView()
            }
        }
        get {
            return self.localCurrentImage!
        }
    }
    
    var isSquare: Bool {
        set {
            if localIsSquare != newValue {
                localIsSquare = newValue
                creatPointView()
            }
        }
        get {
            return self.localIsSquare
        }
    }

    var currentWidthMultiple: CGFloat {
        set {
            if localCurrentWidthMultiple != newValue {
                localCurrentWidthMultiple = newValue
                creatPointView()
            }
        }
        get {
            return self.localCurrentWidthMultiple
        }
    }
    var otherBorderColor: UIColor {
        set {
            localOtherBorderColor = newValue
            creatPointView()
        }
        get {
            return self.localOtherBorderColor!
        }
    }

    var otherBorderWidth: CGFloat {
        set {
            localOtherBorderWidth = newValue
            creatPointView()
        }
        get {
            return self.localOtherBorderWidth!
        }
    }

    var currentBorderColor: UIColor {
        set {
            localCurrentBorderColor = newValue
            creatPointView()
        }
        get {
            return self.localCurrentBorderColor!
        }
    }

    var currentBorderWidth: CGFloat {
        set {
            localCurrentBorderWidth = newValue
            creatPointView()
        }
        get {
            return self.localCurrentBorderWidth!
        }
    }

    func creatPointView() {
        for view in self.subviews {
            view.removeFromSuperview()
        }

        if localNumberOfPages <= 0 {//
            return
        }

        var startX: CGFloat = 0
        var startY: CGFloat = 0
        let mainWidth = CGFloat(localNumberOfPages) * (localPointSize.width + localPointSpace)

        if self.frame.size.width > mainWidth {
            startX = (self.frame.size.width - mainWidth) / 2
        }

        if self.frame.size.height > localPointSize.height {
            startY = (self.frame.size.height - localPointSize.height) / 2
        }

        //
        for index in 0 ..< numberOfPages {
            if index == localCurrentPage {//
                let currentPointView = UIView.init()
                let currentPointViewWidth = localPointSize.width * localCurrentWidthMultiple
                currentPointView.frame = CGRect.init(x: startX, y: startY, width: currentPointViewWidth, height: localPointSize.height)
                currentPointView.backgroundColor = localCurrentColor
                currentPointView.tag = index + 1000
                currentPointView.layer.cornerRadius = localIsSquare ? 0 : localPointSize.height / 2
                currentPointView.layer.masksToBounds = true
                currentPointView.layer.borderColor = localCurrentBorderColor != nil ? localCurrentBorderColor?.cgColor : localCurrentColor.cgColor
                currentPointView.layer.borderWidth = localCurrentBorderWidth != nil ? localCurrentBorderWidth! : 0
                currentPointView.isUserInteractionEnabled = true
                self.addSubview(currentPointView)
                let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(clickAction(tapGesture:)))//
                currentPointView.addGestureRecognizer(tapGesture)
                startX = currentPointView.frame.maxX + localPointSpace

                if localCurrentImage != nil {
                    currentPointView.backgroundColor = UIColor.clear
                    let localCurrentImageView = UIImageView.init()
                    localCurrentImageView.tag = index + 2000
                    localCurrentImageView.frame = currentPointView.bounds
                    localCurrentImageView.image = localCurrentImage
                    currentPointView.addSubview(localCurrentImageView)
                }
            } else {//
                let otherPointView = UIView.init()
                otherPointView.frame = CGRect.init(x: startX, y: startY, width: localPointSize.width, height: localPointSize.height)
                otherPointView.backgroundColor = localOtherColor
                otherPointView.tag = index + 1000
                otherPointView.layer.cornerRadius = localIsSquare ? 0 : localPointSize.height / 2
                otherPointView.layer.borderColor = localOtherBorderColor != nil ? localOtherBorderColor?.cgColor : localOtherColor.cgColor
                otherPointView.layer.borderWidth = localOtherBorderWidth != nil ? localOtherBorderWidth! : 0
                otherPointView.layer.masksToBounds = true
                otherPointView.isUserInteractionEnabled = true
                self.addSubview(otherPointView)
                let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(clickAction(tapGesture:)))
                otherPointView.addGestureRecognizer(tapGesture)
                startX = otherPointView.frame.maxX + localPointSpace

                if localOtherImage != nil {
                    otherPointView.backgroundColor = UIColor.clear
                    let localOtherImageView = UIImageView.init()
                    localOtherImageView.tag = index + 2000
                    localOtherImageView.frame = otherPointView.bounds
                    localOtherImageView.image = localOtherImage
                    otherPointView.addSubview(localOtherImageView)
                }
            }
        }
    }

    func exchangeCurrentView(oldSelectedIndex: NSInteger, newSelectedIndex: NSInteger) {//
        let oldPointView = self.viewWithTag(1000 + oldSelectedIndex)
        let newPointView = self.viewWithTag(1000 + newSelectedIndex)

        oldPointView?.layer.borderColor = localOtherBorderColor != nil ? localOtherBorderColor?.cgColor : localOtherColor.cgColor
        oldPointView?.layer.borderWidth = localOtherBorderWidth != nil ? localOtherBorderWidth! : 0

        newPointView?.layer.borderColor = localCurrentBorderColor != nil ? localCurrentBorderColor?.cgColor : localCurrentColor.cgColor
        newPointView?.layer.borderWidth = localCurrentBorderWidth != nil ? localCurrentBorderWidth! : 0

        oldPointView?.backgroundColor = localOtherColor
        newPointView?.backgroundColor = localCurrentColor

        if localCurrentWidthMultiple != 1 {//，frame
            var oldPointFrame = oldPointView?.frame
            if newSelectedIndex < oldSelectedIndex {
                oldPointFrame?.origin.x += localPointSize.width * (localCurrentWidthMultiple - 1)
            }
            oldPointFrame?.size.width = localPointSize.width
            oldPointView?.frame = oldPointFrame!

            var newPointFrame = newPointView?.frame
            if newSelectedIndex > oldSelectedIndex {
                newPointFrame?.origin.x -= localPointSize.width * (localCurrentWidthMultiple - 1)
            }
            newPointFrame?.size.width = localPointSize.width * localCurrentWidthMultiple
            newPointView?.frame = newPointFrame!
        }

        if localCurrentImage != nil {//
            let view = oldPointView?.viewWithTag(oldSelectedIndex + 2000)

            if view != nil {
                let oldlocalCurrentImageView = view as! UIImageView

                oldlocalCurrentImageView.frame = CGRect.init(x: 0, y: 0, width: localPointSize.width, height: localPointSize.height)
                oldlocalCurrentImageView.image = localOtherImage
            }
        }

        if localOtherImage != nil {//
            let view = newPointView?.viewWithTag(newSelectedIndex + 2000)
            if view != nil {
                let oldlocalOtherImageView = view as! UIImageView
                let width = localPointSize.width * localCurrentWidthMultiple

                oldlocalOtherImageView.frame = CGRect.init(x: 0, y: 0, width: width, height: localPointSize.height)
                oldlocalOtherImageView.image = localCurrentImage

            }
        }

        if newSelectedIndex - oldSelectedIndex > 1 {//，
            for index in oldSelectedIndex + 1 ..< newSelectedIndex {
                let view = self.viewWithTag(1000 + index)
                var frame = view?.frame
                frame?.origin.x -= localPointSize.width * (localCurrentWidthMultiple - 1)
                frame?.size.width = localPointSize.width
                view?.frame = frame!
            }
        }

        if newSelectedIndex - oldSelectedIndex < -1 {//，
            for index in newSelectedIndex + 1 ..< oldSelectedIndex {
                let view = self.viewWithTag(1000 + index)
                var frame = view?.frame
                frame?.origin.x += localPointSize.width * (localCurrentWidthMultiple - 1)
                frame?.size.width = localPointSize.width
                view?.frame = frame!
            }
        }
    }
}
