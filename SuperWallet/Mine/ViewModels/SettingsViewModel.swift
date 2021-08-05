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

    var autoLockOptions: [AutoLock] {
        return [
            AutoLock.immediate,
            AutoLock.oneMinute,
            AutoLock.fiveMinutes,
            AutoLock.oneHour,
            AutoLock.fiveHours
        ]
    }    

    var currency: [Currency] {
        return Currency.allValues.map { $0 }
    }
}
