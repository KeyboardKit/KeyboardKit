//
//  KeyboardViewController.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2023-02-13.
//  Copyright © 2023-2026 Kankoda. All rights reserved.
//

import KeyboardKit
import KeyboardKitHostPlugin                                // <-- 💡 Host Application
import SwiftUI

/// This keyboard shows how to set up `KeyboardKit Pro`, and
/// how to customize the keyboard in various ways.
///
/// This keyboard lets you test most features, like the many
/// languages, iPad-specific features, the autocomplete tool,
/// an emoji keyboard, themes, etc.
///
/// For app-specific features, check out the main app target.
class KeyboardViewController: KeyboardInputViewController {

    /// ‼️ If this doesn't log when the debugger is attached,
    /// there is a memory leak.
    deinit {
        NSLog("__DEINIT__")
    }

    /// This function is called when the controller launches,
    /// and is where you can set up KeyboardKit for your app.
    override func viewWillSetupKeyboardKit() {

        // Set up the keyboard with the demo-specific app.
        setupKeyboardKit(
            for: .keyboardKitDemo,
            hostApplicationResolver: pluginHostApplicationResolver  // <-- 💡 Host Application
        ) { [weak self] result in
            switch result {                                 // <-- 💡 Handle the license result
            case .success:
                self?.setupDemoServices()                   // <-- 💡 Set up demo-specific services.
                self?.setupDemoState()                      // <-- 💡 Set up demo-specific state.
            case .failure(let error):
                print(error)                                // <-- 🚨 If this is called, the license failed.
            }
        }
    }

    /// This function is called when the controller needs to
    /// redraw the keyboard view, and is where you can setup
    /// a custom view or customize the standard KeyboardView.
    override func viewWillSetupKeyboardView() {
        // super.viewWillSetupKeyboardView()                // <-- 💡 Don't call super.
        setupKeyboardView { /*[weak self]*/ controller in   // <-- 💡 Use weak or unowned self.
            DemoKeyboardView(                               // <-- 💡 Sets up a demo-specific keyboard view.
                services: controller.services,
                state: controller.state
            )
        }
    }
}

private extension KeyboardViewController {

    /// Make demo-specific changes to your keyboard services.
    func setupDemoServices() {
        services.actionHandler = DemoKeyboardActionHandler( // <-- 💡 Set up a demo-specific action handler.
            controller: self
        )
    }

    /// Make demo-specific changes to your keyboard's state.
    func setupDemoState() {

        /// 💡 Set up which locale to use to present locales.
        state.keyboardContext.localePresentationLocale = .current

        /// 💡 Configure various settings
        // state.autocompleteSettings.isAutocorrectEnabled = false
        state.keyboardSettings.spacebarLongPressBehavior = .moveInputCursor
        state.keyboardSettings.spacebarMenuTrailing = .locale

        /// 💡 Setup demo-specific haptic & audio feedback.
        let feedback = state.feedbackContext
        feedback.registerCustomFeedback(.haptic(.selectionChanged, for: .repeat, on: .rocket))
        feedback.registerCustomFeedback(.audio(.rocketFuse, for: .press, on: .rocket))
        feedback.registerCustomFeedback(.audio(.rocketLaunch, for: .release, on: .rocket))
    }
}
