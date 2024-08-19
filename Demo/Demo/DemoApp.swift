//
//  DemoApp.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI
import KeyboardKitPro

/// This is the main demo app.
///
/// This app contains two keyboard extensions, that can both
/// be enabled from System Settings. Full Access is required
/// for certain features, like haptic feedback.
///
/// This main app uses a `KeyboardAppView` to set up the app.
/// It will register the KeyboardKit Pro license, set up any
/// state that are required, etc.
///
/// `IMPORTANT` Although this app lets you test the keyboard
/// app screens, as well as dictation, the app does NOT sync
/// settings between the main app and its keyboards since it
/// is not code signed, and therefore can't use an App Group.
/// This is why the keyboard extensions use the keyboard and
/// locale setting screens as sheets, since they cannot read
/// settings from the main app. If your app has an App Group,
/// you only have to manage settings in the main app.
///
/// `ALSO` While the Pro keyboard *can* open the demo app to
/// start dictation, and the app *can* perform dictation and
/// return to *some* (supported) apps, the app can NOT write
/// dictated text to an App Group to share with the keyboard.
@main
struct DemoApp: App {

    var body: some Scene {
        WindowGroup {
            KeyboardAppView(for: .demoApp) {
                HomeScreen()
            }
        }
    }
}
