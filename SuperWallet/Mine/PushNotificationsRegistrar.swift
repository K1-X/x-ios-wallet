// Copyright DApps Platform Inc. All rights reserved.

import Foundation
import UserNotifications
import UIKit
import Moya
import TrustCore

class PushNotificationsRegistrar: NSObject {

    private let provider = SuperWalletProviderFactory.makeProvider()
    let config = Config()

    func register(launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        let entiity = JPUSHRegisterEntity()
        entiity.types = Int(UNAuthorizationOptions.alert.rawValue |
            UNAuthorizationOptions.badge.rawValue |
            UNAuthorizationOptions.sound.rawValue)
        JPUSHService.register(forRemoteNotificationConfig: entiity, delegate: self)
        JPUSHService.setup(withOption: launchOptions,
                           appKey: JPushAppKey,
                           channel: "appstore",
                           apsForProduction: false)
    }
}  
