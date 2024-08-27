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
/// The app has two keyboard extensions. They can be enabled
/// from System Settings and require Full Access to use some
/// features, like haptic feedback.
///
/// The app uses a `KeyboardAppView` to set up the app while
/// the keyboard extensions use `setup` and `setupPro`. This
/// will register the KeyboardKit Pro license, sets up state
/// and services, etc.
///
/// Use the `Keyboard` keyboard to play around with the open
/// source SDK. It adds KeyboardKit as a local dependency to
/// let you change any code and immediately see the result.
///
/// Use the `KeyboardPro` keyboard to test the closed-source
/// SDK and many of the features it provides. It adds KK Pro
/// as a closed-source binary dependency, but you can adjust
/// it with the `KeyboardPro` source code.
///
/// `NOTE` To avoid having to duplicate services between the
/// two keyboard targets, they define preprocessor macros to
/// let the files conditionally import KeyboardKit or KK Pro.
/// This is only a demo detail. You don't have to do this in
/// your own app, since you'll either use KeyboardKit or Pro. 
///
/// `IMPORTANT` Although this app lets you test the keyboard
/// settings screens and start dictation, the app can't sync
/// data between itself and its keyboards, since it does not
/// use code signing. To make syncing work in your app, just
/// create an App Group and link it to your app and keyboard.
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
