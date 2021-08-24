import UIKit

class TextInsetLabel: UILabel {

    var edgeInsets: UIEdgeInsets?

    override init(frame: CGRect) {
        super.init(frame: frame)
        edgeInsets = .zero
    }

    required init?(coder aDecoder: NSCoder) {
        edgeInsets = .zero
        super.init(coder: aDecoder)
    }

    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, edgeInsets!))
    }
    
}
