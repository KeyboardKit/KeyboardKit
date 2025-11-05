//
//  DemoApp.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import SwiftUI
import KeyboardKit

/// This is the KeyboardKit demo app.
///
/// The main app target shows you how `KeyboardKit Pro` lets
/// you create a great keyboard app, in which a user can set
/// up and configure the keyboard in in-app settings screens.
/// The `Keyboard` keyboard uses `KeyboardKit` to show basic
/// keyboard usage while `KeyboardPro` uses `KeyboardKit Pro`
/// to unlock localized layouts, emojis, settings, etc.
///
/// To run this demo on a physical device, you must register
/// your development team under `Signing & Capabilities` for
/// all three targets.
///
/// `IMPORTANT` This demo has no App Group by default, which
/// means that keyboard settings won't sync between the main
/// app and its keyboards. This is why the `KeyboardPro` has
/// in-keyboard settings screens. To make settings sync, you
/// have to change the bundle ID of all targets, then create
/// an App Group in the Apple Developer Portal and add it to
/// all three targets, then change the `appGroupId` value in
/// `KeyboardApp+Demo.swift`.
@main
struct DemoApp: App {

    init() {
        // subscribeToKeyboardNotifications()
    }

    var body: some Scene {
        WindowGroup {
            KeyboardAppView(for: .keyboardKitDemo) {
                HomeScreen()
            }
        }
    }
}

private extension DemoApp {

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
