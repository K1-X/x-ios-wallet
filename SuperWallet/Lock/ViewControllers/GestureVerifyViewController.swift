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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    func createView() {
        let msgLabel = SPLockLabel()
        msgLabel.textAlignment = .center
        self.msgLabel = msgLabel
        self.msgLabel?.showNormalMag(msg: gestureTextOldGesture as NSString)
        view.addSubview(msgLabel)

        //
        let lockView = SPCircleView()
        lockView.arrow = true
        lockView.delegate = self
        lockView.type = CircleViewType.circleViewTypeVerify
        self.lockView = lockView
        view.addSubview(lockView)
        msgLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(140)
            make.leading.equalToSuperview().offset(edgeWidth)
            make.trailing.equalToSuperview().offset(-edgeWidth)
            make.height.equalTo(20)
        }
        lockView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(msgLabel.snp.bottom).offset(20)
            make.width.equalTo(screenWidth - CircleViewEdgeMargin*2)
            make.height.equalTo(screenWidth - CircleViewEdgeMargin*2)
        }

        let infoView = SPCircleInfoView()
        self.infoView = infoView
        view.addSubview(infoView)
        infoView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(navigationHeight + 20)
            make.size.equalTo(CGSize(width: CircleRadius * 2 * 0.6, height: CircleRadius * 2 * 0.6))
        }
    }
  
    private func unlock(withResult success: Bool, bioUnlock: Bool) {
        self.view.endEditing(true)
        if success {
            lock!.removeAutoLockTime()
        }
        if let unlock = unlockWithResult {
            unlock(success, bioUnlock)
        }
    }


    func touchId() {
        //
        if (lock?.getTouchId())! {
            //
            let authenticationContext = LAContext()
            var error: NSError?
            //1：Touch ID
            let isTouchIdAvailable = authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
            //,
            if isTouchIdAvailable {
                authenticationContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "", reply: {
                    (success, error) -> Void in
                    if success {
                        //View,
                        OperationQueue.main.addOperation {
                            print("\(Thread.current)")
//                            self.lockView!.isHidden = true
//                            self.msgLabel?.isHidden = true
                            self.unlock(withResult: true, bioUnlock: false)
                        }
                    } else {
                        print("，Touch ID！\n\(String(describing: error))")
                    }
                })
            } else {
                print("")
            }
        } else {
            print("")
        }
    }
}

extension GestureVerifyViewController: SPCircleViewDelegate {
    func circleViewdidCompleteLoginGesture(_ view: SPCircleView, type: CircleViewType, gesture: String, result: Bool) {
        if type == CircleViewType.circleViewTypeVerify {
            if result {
                if isToSetNewGesture {
                    let gesture = GestureViewController()
                    gesture.type = GestureViewControllerType.setting
                    navigationController?.pushViewController(gesture, animated: true)
                } else {
                    unlock(withResult: true, bioUnlock: false)
                }
            } else {
                print("!")
                self.msgLabel?.showWarnMsg(msg: gestureTextGestureVerifyError)
            }
        }
    }

    func circleViewdidCompleteSetFirstGesture(_ view: SPCircleView, type: CircleViewType, gesture: String) {

    }

    func circleViewConnectCirclesLessThanNeedWithGesture(_ view: SPCircleView, type: CircleViewType, gesture: String) {

    }

    func circleViewdidCompleteSetSecondGesture(_ view: SPCircleView, type: CircleViewType, gesture: String, result: Bool) {

    }
}
