// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UIKit

extension CALayer {

    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let border = CALayer()
        switch edge {
        case UIRectEdge.top:
            border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: thickness)
        case UIRectEdge.bottom:
            border.frame = CGRect.init(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        case UIRectEdge.left:
            border.frame = CGRect.init(x: 0, y: 0, width: thickness, height: frame.height)
        case UIRectEdge.right:
            border.frame = CGRect.init(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
        default:
            break
        }
        border.backgroundColor = color.cgColor
        self.addSublayer(border)
    }    

    func shake() {
        let kfa = CAKeyframeAnimation.init(keyPath: "transform.translation.x")
        let s:CGFloat = 5.0
        kfa.values = [(-s),(0),s,0,-s,0,s,0]
        kfa.duration = 0.3
        kfa.repeatCount = 2
        kfa.isRemovedOnCompletion = true
        add(kfa, forKey: "shake")
    }
}
