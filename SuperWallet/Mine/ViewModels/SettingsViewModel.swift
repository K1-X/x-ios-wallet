// Copyright DApps Platform Inc. All rights reserved.

import Foundation

struct SettingsViewModel {

    private let isDebug: Bool

    init(
        isDebug: Bool = false
    ) {
        self.isDebug = isDebug
    }

    var servers: [RPCServer] {
        return [
            RPCServer.main
        ]
    }
    
}
