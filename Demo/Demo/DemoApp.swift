//
//  DemoApp.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021-2026 Kankoda. All rights reserved.
//

import SwiftUI
import KeyboardKit
import KeyboardKitDictationPlugin                           // <-- 💡 Dictation

extension PluginDictationEngine: @retroactive DictationEngine {}  // <-- 💡 Dictation

/// This is the KeyboardKit demo app.
///
/// The main app target shows you how to set up the main app
/// to use KeyboardKit, while the `Keyboard` keyboard target
/// shows how to do the same for the keyboard extension.
///
/// To run this demo on a physical device, you must register
/// your team under `Signing & Capabilities` for all targets.
///
/// `IMPORTANT` This demo has no App Group, which means that
/// the settings won't sync between the app and the keyboard.
/// Therefore, the keyboard has in-keyboard settings screens
/// to let you test settings in the keyboard. To enable data
/// sync, you must change the bundle ID of all targets, then
/// create an App Group in the Apple Developer Portal, after
/// this, you must configure it as shown in the docs.
@main
struct DemoApp: App {

    init() {
        // subscribeToKeyboardNotifications()
    }

    var body: some Scene {
        WindowGroup {
            KeyboardAppView(
                for: .keyboardKitDemo,
                dictationEngine: pluginDictationEngine      // <-- 💡 Dictation
            ) {
                HomeScreen()
            }
        }
    }
}

private extension DemoApp {

    /// Call this function from the initializer to print all
    /// keyboard frame changes. You can use this to debug if
    /// the keyboard resizing starts misbehaving.
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            forName: UIResponder.keyboardWillShowNotification,
            object: nil,
            queue: .main
        ) { notification in
            let key = UIResponder.keyboardFrameEndUserInfoKey
            if let keyboardFrame = notification.userInfo?[key] as? CGRect {
                print("Keyboard height: \(keyboardFrame.height)")
            }
        }
    }
}
