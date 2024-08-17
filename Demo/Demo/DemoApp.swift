//
//  DemoApp.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/// This is the main demo app.
///
/// This app contains two keyboard extensions, that can both
/// be enabled from System Settings. Full Access is required
/// for certain features, like haptic feedback.
///
/// `IMPORTANT` Although this app lets you test the keyboard
/// and language settings screens, as well as dictation, the
/// app does NOT sync settings between the app and keyboards.
/// This requires an App Group, which requires the app to be
/// code signed. This is why these keyboards must have their
/// own settings, which is otherwise not needed. Furthermore,
/// while the Pro keyboard *can* open this demo app to start
/// dictation, and the demo app *can* perform dictation then
/// return to *some* apps, the dictated text isn't available
/// to the keyboard since no App Group can be created.
@main
struct DemoApp: App {

    init() {
        // Call this as early as possible to set up keyboard
        // settings to sync between the app and its keyboard.
        // KeyboardSettings.setupStore(withAppGroup: "group.com.your-app-id")
    }

    var body: some Scene {
        WindowGroup {
            HomeScreen()
        }
    }
}
