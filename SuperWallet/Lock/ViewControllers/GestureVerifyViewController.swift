// Copyright DApps Platform Inc. All rights reserved.

import UIKit
import LocalAuthentication

class GestureVerifyViewController: UIViewController {

    var unlockWithResult: ((_ success: Bool, _ bioUnlock: Bool) -> Void)?
    /// 
    var isToSetNewGesture: Bool = false
    /// Label
    fileprivate var msgLabel: SPLockLabel?
    /// 
    fileprivate  var lockView: SPCircleView?
    /// infoView
    fileprivate var infoView: SPCircleInfoView?
    var lock: Lock?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CircleViewBackgroundColor
        lock = Lock()
        createView()
    }    
}
