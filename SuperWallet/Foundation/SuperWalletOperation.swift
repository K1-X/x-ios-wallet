// Copyright DApps Platform Inc. All rights reserved.

import UIKit

class SuperWalletOperation: Operation {

    enum KVOProperties {
        static let isFinished = "isFinished"
        static let isExecuting = "isExecuting"
    }
    

    private var _finished = false
    private var _isExecuting = false

    override public var isFinished: Bool {
        get { return _finished }
        set {
            willChangeValue(forKey: KVOProperties.isFinished)
            _finished = newValue
            didChangeValue(forKey: KVOProperties.isFinished)
        }
    }
}
