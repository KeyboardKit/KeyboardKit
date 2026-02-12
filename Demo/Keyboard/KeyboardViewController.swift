//
//  KeyboardViewController.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2023-02-13.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/// This keyboard shows how to set up `KeyboardKit Pro` with
/// a `KeyboardApp` and customize the keyboard.
///
/// This keyboard lets you test open-source and Pro features,
/// like fully localized keyboards, iPad Pro layouts, emojis,
/// autocomplete, themes, etc.
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

        /// 🧪 Enable experimental features
        Experiment.keyboardDictation.setIsEnabled(true)

        // Set up the keyboard with the demo-specific app.
        setupKeyboardKit(for: .keyboardKitDemo) { [weak self] result in

            /// 💡 If the setup worked, we can customize the
            /// keyboard. If not, we should handle the error.
            switch result {
            case .success:
                self?.setupDemoServices()
                self?.setupDemoState()
            case .failure(let error):
                print(error)
            }
        }
    }

    /// This function is called when the controller needs to
    /// redraw the keyboard view, and is where you can setup
    /// a custom view or customize the standard KeyboardView.
    override func viewWillSetupKeyboardView() {

        // ⚠️ Don't call `super.viewWillSetupKeyboardView()`.
        // super.viewWillSetupKeyboardView()

        // Set up a custom, demo-specific keyboard view.
        setupKeyboardView { /*[weak self]*/ controller in

            // 💡 This demo keyboard view will apply various
            // view modifiers based on this controller state.
            DemoKeyboardView(
                services: controller.services,
                state: controller.state
            )
        }
    }
}

private extension KeyboardViewController {

    /// Make demo-specific changes to your keyboard services.
    func setupDemoServices() {

        // 💡 Set up am action handler for our rocket button.
        services.actionHandler = DemoActionHandler(
            controller: self
        )
    }

    /// Make demo-specific changes to your keyboard's state.
    ///
    /// 💡 Many configurations and settings can be made from
    /// the demo keyboard's custom toolbar.
    func setupDemoState() {

        /// 💡 Set up which locale to use to present locales.
        state.keyboardContext.localePresentationLocale = .current

        /// 💡 Configure the space key's behavior and action.
        state.keyboardContext.settings.spacebarLongPressBehavior = .moveInputCursor
        // state.keyboardContext.settings.spacebarContextMenuLeading = .locale
        state.keyboardContext.settings.spacebarMenuTrailing = .locale

        /// 💡 Disable autocorrection.
        // state.autocompleteContext.isAutocorrectEnabled = false

        /// 💡 Setup demo-specific haptic & audio feedback.
        let feedback = state.feedbackContext
        feedback.registerCustomFeedback(.haptic(.selectionChanged, for: .repeat, on: .rocket))
        feedback.registerCustomFeedback(.audio(.rocketFuse, for: .press, on: .rocket))
        feedback.registerCustomFeedback(.audio(.rocketLaunch, for: .release, on: .rocket))
    }
}
