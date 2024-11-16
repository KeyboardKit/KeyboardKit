//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/// This keyboard shows you how to set up `KeyboardKit` with
/// a `KeyboardApp` and customize the standard keyboard view,
/// adding `KeyboardKit` as a local dependency.
///
/// This demo is intentionally kept very basic, to provide a
/// starting point for you to play around with this keyboard.
/// You can customize the keyboard views, state and services.
///
/// See the `KeyboardPro` keyboard for a more extensive demo.
class KeyboardViewController: KeyboardInputViewController {

    /// This function is called when the controller launches.
    ///
    /// Call `setup(for:)` here to set up the controller for
    /// the `.keyboardKitDemo` app in `KeyboardApp+Demo`.
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
    /// keyboard view, or customize the standard view.
    ///
    /// 💡 You don't have to override this function when you
    /// want to use a standard `KeyboardView`.
    override func viewWillSetupKeyboardView() {

        /// 💡 Always call super :)
        super.viewWillSetupKeyboardView()

        /// 💡 Call `setupKeyboardView(...)` to customize or
        /// replace the standard `KeyboardView`.
        ///
        /// You can replace `KeyboardView` with another view.
        setupKeyboardView { controller in
            KeyboardView(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                collapsedView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { params in params.view }  // This is the same as $0.view
            )
            // Apply global view modifiers here, e.g. styles.
            // .autocorrectionDisabled()
            // .calloutStyle(.init(backgroundColor: .red))
        }
    }
}

private extension KeyboardViewController {

    /// Make demo-specific service changes.
    ///
    /// You can add your own customizations here, to see how
    /// it affects the keyboard behavior.
    func setupDemoServices() {

        /// 💡 Register a demo-specific autocomplete service
        /// that provides the keyboard with fake suggestions.
        services.autocompleteService = FakeAutocompleteService(
            context: state.autocompleteContext
        )
    }

    /// Make demo-specific state changes.
    ///
    /// You can add your own customizations here, to see how
    /// it affects the keyboard behavior.
    func setupDemoState() {

        /// 💡 Configure the space key's long press behavior.
        /// Note that this demo only supports English.
        state.keyboardContext.spaceLongPressBehavior = .moveInputCursor
        // state.keyboardContext.spaceLongPressBehavior = .openLocaleContextMenu
    }
}
