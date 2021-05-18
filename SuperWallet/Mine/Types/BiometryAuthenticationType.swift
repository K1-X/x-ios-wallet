// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import LocalAuthentication


enum BiometryAuthenticationType {
    case touchID
    case faceID
    case none

    var title: String {
        switch self {
        case .faceID: return "FaceID"
        case .touchID: return "Touch ID"
        case .none: return ""
        }
    }

}
