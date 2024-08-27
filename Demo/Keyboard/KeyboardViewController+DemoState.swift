//
//  KeyboardViewController+DemoState.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-08-27.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

#if IS_KEYBOARDKIT
import KeyboardKit
#else
import KeyboardKitPro
#endif

extension KeyboardViewController {

    /// This function is used by the keyboard controller, to
    /// set up demo-specific keyboard state.
    func setupDemoState() {

        /// 💡 Set up which locale to use to present locales,
        /// for instance in the locale switcher context menu.
        state.keyboardContext.localePresentationLocale = .current
        // state.keyboardContext.locales = This is set to the license locales

        /// 💡 Configure the space key's long press behavior.
        state.keyboardContext.spaceLongPressBehavior = .moveInputCursor
        // state.keyboardContext.spaceLongPressBehavior = .openLocaleContextMenu

        /// 💡 Disable autocorrection.
        // state.autocompleteContext.isAutocorrectEnabled = false

        /// 💡 Setup semi-working dictation. It will trigger
        /// the app, but dictation result will not be synced.
        state.dictationContext.setup(with: .app)

        /// 💡 Set up demo-specific haptic & audio feedback.
        let feedback = state.feedbackContext
        feedback.audioConfiguration = .enabled
        feedback.hapticConfiguration = .enabled
        feedback.registerCustomFeedback(.haptic(.selection, for: .repeat, on: .rocket))
        feedback.registerCustomFeedback(.audio(.rocketFuse, for: .press, on: .rocket))
        feedback.registerCustomFeedback(.audio(.rocketLaunch, for: .release, on: .rocket))
    }
}
