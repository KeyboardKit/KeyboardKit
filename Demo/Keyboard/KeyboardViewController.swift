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
/// out the open-source features. You can customize the main
/// keyboard view and the state and services, but for a more
/// extensive demo, see the `KeyboardPro` keyboard.
///
/// For app-specific features, check out the main app target.
class KeyboardViewController: KeyboardInputViewController {

    /// This function is called when the controller launches.
    ///
    /// Here, we call `setup(for:)` to set up the controller
    /// with the shared `.keyboardKitDemo` application.
    override func viewDidLoad() {

        // 💡 Always call `super.viewDidLoad()`.
        super.viewDidLoad()

        // ‼️ Set up the keyboard with the demo-specific app.
        super.setup(for: .keyboardKitDemo)

        // 💡 You can replace services with custom services.
        services.autocompleteService = services.autocompleteService

        // 💡 You can set auto-persisted settings using code.
        let keyboardSettings = state.keyboardContext.settings
        // keyboardSettings.keyboardDockEdge = .leading
        // state.keyboardContext.locales = [.english, .swedish]
        keyboardSettings.spaceContextMenuTrailing = .locale
        keyboardSettings.spaceLongPressBehavior = .moveInputCursor
        // let feedbackSettings = state.feedbackContext.settings
        // feedbackSettings.isAudioFeedbackEnabled = false
        // feedbackSettings.isHapticFeedbackEnabled = false
    }
    
    /// This function is called when the controller needs to
    /// create or update the keyboard view.
    ///
    /// Call `setupKeyboardView(_:)` here to set up a custom
    /// keyboard view or customize the default `KeyboardView`.
    override func viewWillSetupKeyboardView() {

        // 💡 Don't call `super.viewWillSetupKeyboardView()`.
        // super.viewWillSetupKeyboardView()

        // ‼️ Customize the standard keyboard view component.
        //
        // You should define the keyboard view in a new view
        // to ensure that it properly observes your contexts.
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

            // 💡 Disable autocorrection using plain SwiftUI.
            // .autocorrectionDisabled()

            // 💡 Customize the style of any keyboard button.
            .keyboardButtonStyle { params in
                let context = controller.state.keyboardContext
                var style = params.standardStyle(for: context)
                guard params.action == .backspace else { return style }
                style.backgroundColor = params.isPressed ? .yellow : .blue
                return style
            }

            // 💡 Setup custom callout actions for the k key.
            .keyboardCalloutActions { params in
                let context = controller.state.keyboardContext
                if let actions = params.action.customCalloutActions { return actions }
                return params.standardActions(for: context)
            }

            // 💡 Customize the style of the entire keyboard.
            // .keyboardViewStyle(
            //     .init(background: .color(.green))
            // )

            // 💡 Customize other custom view styles as well.
            // .keyboardToolbarStyle(.init(backgroundColor: .red))
        }
    }
}

private extension KeyboardAction {

    var customCalloutActions: [KeyboardAction]? {
        switch self {
        case .character(let char): customCalloutAction(for: char)
        default: nil
        }
    }

    func customCalloutAction(for char: String) -> [KeyboardAction]? {
        guard char.lowercased() == "k" else { return nil }
        let custom = String("keyboardkit".reversed())
        return [KeyboardAction].init(characters: custom)
    }
}
