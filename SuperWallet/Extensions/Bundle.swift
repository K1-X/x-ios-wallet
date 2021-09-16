// Copyright DApps Platform Inc. All rights reserved.

import Foundation

extension Bundle {

    var versionNumber: String? {
        return infoDictionary?["CFBundleShortVersionString"] as? String
    }
    var buildNumber: String? {
        return infoDictionary?["CFBundleVersion"] as? String
    }

    var buildNumberInt: Int {
        return Int(Bundle.main.buildNumber ?? "-1") ?? -1
    }    
}
