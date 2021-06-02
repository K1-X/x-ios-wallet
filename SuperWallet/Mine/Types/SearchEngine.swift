// Copyright DApps Platform Inc. All rights reserved.

import Foundation

enum SearchEngine: Int {

    case google = 0
    case duckDuckGo

    static var `default`: SearchEngine {
        return .google
    }    

    var title: String {
        switch self {
        case .google:
            return R.string.localizable.google()
        case .duckDuckGo:
            return R.string.localizable.duckDuckGo()
        }
    }

    var host: String {
        switch self {
        case .google:
            return "google.com"
        case .duckDuckGo:
            return "duckduckgo.com"
        }
    }
}
