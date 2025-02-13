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
/// This keyboard is very basic, to provide a starting point
/// for trying out the open-source features. You can perform
/// any customizations to the keyboard, state & services and
/// inject any custom views into the keyboard.
///
/// See the `KeyboardPro` keyboard for a more extensive demo,
/// and the `DemoApp.swift` for more info about the demo app.
class KeyboardViewController: KeyboardInputViewController {

    /// This function is called when the controller launches.
    ///
    /// Call `setup(for:)` to set up this controller for the
    /// `.keyboardKitDemo` application.
    override func viewDidLoad() {

        /// 💡 Always call `super.viewDidLoad()`.
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

        /// 💡 Don't call `super.viewWillSetupKeyboardView()`.
        // super.viewWillSetupKeyboardView()

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

    /// Make demo-specific changes to your keyboard services.
    func setupDemoServices() {

        /// 💡 You can replace any service with a custom service.
        services.autocompleteService = services.autocompleteService
    }

    /// Make demo-specific changes to your keyboard's state.
    func setupDemoState() {
        
        /// 💡 This enable more locales.
        state.keyboardContext.locales = [.english, .spanish]
        
        /// 💡 This overrides the standard enabled locales.
        state.keyboardContext.settings.addedLocales = [.init(.english), .init(.swedish)]
        
        /// 💡 Dock the keyboard to any horizontal edge.
        // state.keyboardContext.settings.keyboardDockEdge = .leading

        /// 💡 Configure the space key's long press behavior and trailing action.
        state.keyboardContext.settings.spaceLongPressBehavior = .moveInputCursor
        // state.keyboardContext.settings.spaceContextMenuLeading = .locale
        state.keyboardContext.settings.spaceContextMenuTrailing = .locale

        /// 💡 Customize keyboard feedback.
        // state.feedbackContext.settings.isAudioFeedbackEnabled = false
        // state.feedbackContext.settings.isHapticFeedbackEnabled = false
    }
}
