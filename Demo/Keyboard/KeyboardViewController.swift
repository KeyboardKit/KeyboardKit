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
/// a `KeyboardApp` and customize the standard keyboard view.
///
/// This demo is intentionally kept very basic, to provide a
/// starting point to let you to play with the keyboard. You
/// can customize the keyboard view, state & services and do
/// anything you want.
///
/// See the `KeyboardPro` keyboard for a more extensive demo
/// that shows you how to set up and configure more parts of
/// the keyboard and its functionality.
class KeyboardViewController: KeyboardInputViewController {

    /// This function is called when the controller launches.
    ///
    /// Call `setup(for:)` here to set up the controller for
    /// the `.keyboardKitDemo` app.
    override func viewDidLoad() {

        /// 💡 Always call super :)
        super.viewDidLoad()

        /// ‼️ Set up the keyboard for `.keyboardKitDemo`.
        super.setup(for: .keyboardKitDemo)

        /// 💡 Make basic state & service customizations.
        setupDemoServices()
        setupDemoState()
    }

    /// This function is called when the controller needs to
    /// create or update the keyboard view.
    ///
    /// Call `setupKeyboardView(_:)` here to set up a custom
    /// keyboard view or customize the default `KeyboardView`.
    override func viewWillSetupKeyboardView() {

        /// 💡 Always call super :)
        super.viewWillSetupKeyboardView()

        /// 💡 Call `setupKeyboardView(...)` to customize or
        /// replace the standard `KeyboardView`.
        ///
        /// Return `$0.view` to return the standard view, or
        /// return a custom view for the provided parameters.
        setupKeyboardView { controller in
            KeyboardView(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                collapsedView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { _ in
                    Keyboard.Toolbar {
                        HStack {
                            Spacer()
                            Text("Autocomplete can be tested in the Pro demo.")
                            Spacer()
                        }
                    }
                }
            )
            // .autocorrectionDisabled()
            // .keyboardToolbarStyle(.init(backgroundColor: .red))
        }
    }
}

private extension KeyboardViewController {

    /// Make demo-specific service changes.
    func setupDemoServices() {

        /// 💡 You can replace any service with a custom service.
        services.autocompleteService = services.autocompleteService
    }

    /// Make demo-specific state changes.
    func setupDemoState() {
        
        /// 💡 Enable more locales for the context.
        state.keyboardContext.settings.addedLocales = [.english, .swedish]

        /// 💡 Configure the space key's long press behavior.
        state.keyboardContext.settings.keyboardDockEdge = .leading
        // state.keyboardContext.spaceLongPressBehavior = .moveInputCursor
        state.keyboardContext.spaceLongPressBehavior = .moveInputCursorWithLocaleSwitcher
        // state.keyboardContext.spaceLongPressBehavior = .openLocaleContextMenu

        /// 💡 Enable haptic feedback.
        state.feedbackContext.settings.isHapticFeedbackEnabled = false
    }
}
