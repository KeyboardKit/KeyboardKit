//
//  AppDelegate.swift
//  KeyboardKitDemo
//
//  Created by Daniel Saidi on 2019-10-01.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit
import KeyboardKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, KeyboardStateInspector {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let isEnabled = isKeyboardEnabled(for: "com.danielsaidi.keyboardkit.demo.keyboard")
        let isEnabledSwiftUI = isKeyboardEnabled(for: "com.danielsaidi.keyboardkit.demo.swiftui")
        print(isEnabled ? "UIKit Demo Keyboard is enabled" : "UIKit Demo Keyboard is disabled")
        print(isEnabledSwiftUI ? "SwiftUI Demo Keyboard is enabled" : "SwiftUI Demo Keyboard is disabled")
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
