// Copyright DApps Platform Inc. All rights reserved.

import Foundation

enum SearchEngine: Int {

    case google = 0
    case duckDuckGo

    static var `default`: SearchEngine {
        return .google
    }    
}
