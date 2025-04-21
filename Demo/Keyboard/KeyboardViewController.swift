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
    /// Here, we call `setup(for:)` to set up the controller
    /// with the shared `.keyboardKitDemo` application.
    override func viewDidLoad() {

        /// 💡 Always call `super.viewDidLoad()`.
        super.viewDidLoad()

        /// ‼️ Set up this keyboard with `.keyboardKitDemo`.
        super.setup(for: .keyboardKitDemo)

        /// 💡 You can replace services with custom services.
        services.autocompleteService = services.autocompleteService

        /// 💡 Dock the keyboard view to any horizontal edge.
        // state.keyboardContext.settings.keyboardDockEdge = .leading

        /// 💡 Configure the space key's long press behavior.
        state.keyboardContext.settings.spaceLongPressBehavior = .moveInputCursor

        /// 💡 Configure the space key's additional actions.
        // state.keyboardContext.settings.spaceContextMenuLeading = .locale
        state.keyboardContext.settings.spaceContextMenuTrailing = .locale

        /// 💡 Customize keyboard feedback.
        // state.feedbackContext.settings.isAudioFeedbackEnabled = false
        // state.feedbackContext.settings.isHapticFeedbackEnabled = false
    }
    
    /// This function is called when the controller needs to
    /// create or update the keyboard view.
    ///
    /// Call `setupKeyboardView(_:)` here to set up a custom
    /// keyboard view or customize the default `KeyboardView`.
    ///
    /// Don't call `super.viewWillSetupKeyboardView()` since
    /// that will cause two layout calculations.
    override func viewWillSetupKeyboardView() {

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
            // 💡 Setup custom callout actions for the k key.
            .keyboardCalloutActions { params in
                let action = params.action
                let context = controller.state.keyboardContext
                let custom = String("keyboardkit".reversed())
                if action.shouldUseCustomCallouts { return .init(characters: custom) }
                return params.standardCalloutActions(for: context)
            }
            // .keyboardToolbarStyle(.init(backgroundColor: .red))
        }
    }
}

private extension KeyboardAction {

    var shouldUseCustomCallouts: Bool {
        switch self {
        case .character(let char): char.lowercased() == "k"
        default: false
        }
    }
}
