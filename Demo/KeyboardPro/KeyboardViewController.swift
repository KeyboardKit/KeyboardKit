//
//  KeyboardViewController.swift
//  KeyboardPro
//
//  Created by Daniel Saidi on 2023-02-13.
//  Copyright © 2023-2025 Daniel Saidi. All rights reserved.
//

import KeyboardKitPro
import SwiftUI

/// This keyboard shows how to set up `KeyboardKit Pro` with
/// a `KeyboardApp` and customize the keyboard.
///
/// This keyboard lets you use all open-source features, and
/// KeyboardKit Pro features, like fully localized keyboards,
/// localized iPad Pro layouts, autocomplete, emoji keyboard,
/// dictation, themes, etc.
///
/// For app-specific features, check out the main app target.
class KeyboardViewController: KeyboardInputViewController {

    /// This function is called when the controller launches.
    ///
    /// Here, we call `setup(for:)` to set up the controller
    /// with the shared `.keyboardKitDemo` application.
    override func viewDidLoad() {

        /// 💡 Always call super.viewDidLoad()!
        super.viewDidLoad()

        // ‼️ Set up the keyboard with the demo-specific app.
        super.setup(for: .keyboardKitDemo) { result in
            
            /// 💡 If `result` is successful, the license is
            /// registered and we can customize the keyboard.
            self.setupDemoServices()
            self.setupDemoState()
        }
    }

    /// This function is called when the controller needs to
    /// create or update the keyboard view.
    ///
    /// Call `setupKeyboardView(_:)` here to set up a custom
    /// keyboard view or customize the default `KeyboardView`.
    override func viewWillSetupKeyboardView() {

        // 💡 Don't call `super.viewWillSetupKeyboardView()`.
        // super.viewWillSetupKeyboardView()

        // ‼️ Make the keyboard use the custom keyboard view.
        //
        // Always use `weak self` or `unowned self` when you
        // have to pass on your specific controller class.
        setupKeyboardView { /*[weak self]*/ controller in

            // 💡 This demo keyboard view will apply various
            // view modifiers based on this controller state.
            DemoKeyboardView(
                controller: controller
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

        // 💡 Set up a layout service to get an extra button.
        services.layoutService = DemoLayoutService(
            extraKey: .rocket
        )
    }

    /// Make demo-specific changes to your keyboard's state.
    ///
    /// 💡 Many setting changes can be made from the toolbar.
    func setupDemoState() {

        /// 💡 Set up which locale to use to present locales.
        state.keyboardContext.localePresentationLocale = .current

        /// 💡 Configure the space key's long press behavior and trailing action.
        state.keyboardContext.settings.spaceLongPressBehavior = .moveInputCursor
        // state.keyboardContext.settings.spaceContextMenuLeading = .locale
        state.keyboardContext.settings.spaceContextMenuTrailing = .locale

        /// 💡 Disable autocorrection.
        // state.autocompleteContext.isAutocorrectEnabled = false

        /// 💡 Setup demo-specific haptic & audio feedback.
        let feedback = state.feedbackContext
        feedback.registerCustomFeedback(.haptic(.selection, for: .repeat, on: .rocket))
        feedback.registerCustomFeedback(.audio(.rocketFuse, for: .press, on: .rocket))
        feedback.registerCustomFeedback(.audio(.rocketLaunch, for: .release, on: .rocket))
    }
}
