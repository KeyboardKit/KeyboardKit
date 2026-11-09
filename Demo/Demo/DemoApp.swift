//
//  DemoApp.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021-2026 Kankoda. All rights reserved.
//

import SwiftUI
import KeyboardKit

/// This is the KeyboardKit demo app.
///
/// The main app target shows you how to set up the main app
/// to use KeyboardKit, while the `Keyboard` keyboard target
/// shows you how to do the same for your keyboard extension.
///
/// To run this test on a physical device, you must register
/// your team under `Signing & Capabilities` for all targets.
///
/// `IMPORTANT` This demo has no App Group, which means that
/// the settings won't sync between the app and the keyboard.
/// Therefore, the keyboard has in-keyboard settings screens
/// to let you test settings in the keyboard.
@main
struct DemoApp: App {

    var body: some Scene {
        WindowGroup {
            KeyboardAppView(
                for: .keyboardKitDemo,
                autocompleteEngine: autocompleteEngine,     // <-- 💡 Autocomplete
                dictationEngine: dictationEngine            // <-- 💡 Dictation
            ) {
                HomeScreen()
            }
        }
    }
}
