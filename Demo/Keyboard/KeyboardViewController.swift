//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/// This keyboard shows you how to set up `KeyboardKit` with
/// a `KeyboardApp` and customize the keyboard.
///
/// This keyboard is VERY basic, to provide a way for trying
/// out basic features. For more extensive demos, please see
/// the `KeyboardPro` keyboard.
///
/// For app-specific features, check out the main app target.
class KeyboardViewController: KeyboardInputViewController {

    /// ‼️ If this doesn't log when the debugger is attached,
    /// there is a memory leak.
    deinit {
        NSLog("__DEINIT__")
    }

    /// This function is called when the controller launches.
    ///
    /// Here, we call `setup(for:)` to set up the controller
    /// with the shared `.keyboardKitDemo` application.
    override func viewDidLoad() {

        // 💡 Always call `super.viewDidLoad()`.
        super.viewDidLoad()

        // 💡 Enable the brand new document changed tracking!
        isDocumentChangeTrackingEnabled = true

        // ‼️ Set up the keyboard with the demo-specific app.
        super.setup(for: .keyboardKitDemo) { result in

            /// 💡 If result is successful, we can customize
            /// the controller's services and state.
        }

        // 💡 You can set auto-persisted settings using code.
        // let keyboardSettings = state.keyboardContext.settings
        // keyboardSettings.keyboardDockEdge = .leading
        // keyboardSettings.spaceContextMenuTrailing = .locale
        // keyboardSettings.spaceLongPressBehavior = .moveInputCursor
    }

    /// This function is called when the controller needs to
    /// create or update the keyboard view.
    override func viewWillSetupKeyboardView() {

        // 💡 Don't call `super.viewWillSetupKeyboardView()`.
        // super.viewWillSetupKeyboardView()

        // Set up a custom, demo-specific keyboard view.
        setupKeyboardView { controller in
            DemoKeyboardView(
                services: controller.services,
                state: controller.state
            )
        }
    }
}
