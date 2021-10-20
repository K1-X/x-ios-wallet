// Copyright DApps Platform Inc. All rights reserved.

import Foundation

open class Subscribable<T> {
    private var _value: T?
    private var _subscribers: [(T?) -> Void] = []
    
}
