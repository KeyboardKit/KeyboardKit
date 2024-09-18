//
//  DemoApp.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI
import KeyboardKitPro

/// This is the KeyboardKit demo app.
///
/// This app and the `KeyboardPro` keyboard uses KeyboardKit
/// Pro, while the `Keyboard` keyboard uses KeyboardKit as a
/// local dependency. The keyboards can be enabled in System
/// Settings, and require Full Access for some features.
///
/// The app uses a `KeyboardAppView` to set up the app while
/// the keyboards use `setup` & `setupPro`. This will set up
/// state & services, settings, dictation, etc. and register
/// the KeyboardKit Pro license key.
///
/// The app and its keyboards share files between targets to
/// avoid code duplications. For instance, `KeyboardApp+Demo`
/// is added to all targets. Since it uses both `KeyboardKit`
/// and `KeyboardKit Pro` you will therefore see checks like
/// `#if IS_KEYBOARDKIT`. You do NOT need it in your own app.
///
/// `IMPORTANT` Although this app lets you test the keyboard
/// settings screens and start dictation, it can't sync data
/// between the app and its keyboards, since it's not signed
/// and therefore can't use an App Group. To make it work in
/// your app, just create an App Group, link it to both your
/// app AND keyboard, then add the group ID to `KeyboardApp`.
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
