//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Daniel Saidi on 2021-02-11.
//  Copyright © 2021-2024 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import SwiftUI

/// This keyboard demonstrates how to set up KeyboardKit and
/// customize the standard configuration.
///
/// To use the keyboard, simply enable it in System Settings,
/// then switch to it with the 🌐 key when typing in any app.
class KeyboardViewController: KeyboardInputViewController {

    /// This function is called when the controller launches.
    ///
    /// Below, we make demo-specific keyboard configurations.
    /// Play around with them to see how it affects the demo.
    override func viewDidLoad() {

        // MARK: - App Group Synced Settings

        // Call this as early as possible to set up keyboard
        // settings to sync between the app and its keyboard.
        // KeyboardSettings.setupStore(withAppGroup: "group.com.your-app-id")


        // MARK: - Services

        /// 💡 Setup a demo-specific action handler.
        services.actionHandler = DemoActionHandler(
            controller: self
        )

        /// 💡 Setup a fake autocomplete service.
        services.autocompleteService = FakeAutocompleteService(
            context: state.autocompleteContext
        )
        
        /// 💡 Setup a demo-specific callout service that by
        /// default changes the `k` callout actions.
        services.calloutService = Callouts.StandardService(
            keyboardContext: state.keyboardContext,
            baseService: DemoCalloutService()
        )

        /// 💡 Setup a demo-specific keyboard layout service
        /// that inserts an additional key into the keyboard.
        services.layoutService = DemoLayoutService(.rocket)

        /// 💡 Setup a demo-specific keyboard style that can
        /// change the design of any keys in a keyboard view.
        services.styleProvider = DemoStyleProvider(
            keyboardContext: state.keyboardContext
        )

        // MARK: - State

        /// 💡 Select a custom keyboard locale, although the
        /// open-source keyboard will only localize the keys.
        state.keyboardContext.setLocale(.english)

        /// 💡 Add more locales to the keyboard context. The
        /// locales are only used in the locale context menu
        /// if a user hasn't used a language settings screen.
        state.keyboardContext.setLocales(.all)
        state.keyboardContext.localePresentationLocale = .current

        /// 💡 Configure the space long press behavior. This
        /// can either be used to move the text input cursor
        /// or to show the locale context menu.
        state.keyboardContext.spaceLongPressBehavior = .moveInputCursor
        // state.keyboardContext.spaceLongPressBehavior = .openLocaleContextMenu
        
        /// 💡 Setup haptic and audio feedback, and register
        /// a custom audio sound for the rocket button.
        let feedback = state.feedbackContext
        feedback.audioConfiguration = .enabled
        feedback.hapticConfiguration = .enabled
        feedback.registerCustomFeedback(.haptic(.selection, for: .repeat, on: .rocket))
        feedback.registerCustomFeedback(.audio(.rocketFuse, for: .press, on: .rocket))
        feedback.registerCustomFeedback(.audio(.rocketLaunch, for: .release, on: .rocket))
        
        /// 💡 Call super to perform the base initialization.
        super.viewDidLoad()
    }

    /// This function is called whenever the keyboard should
    /// be created or updated.
    ///
    /// Here, we just setup a standard keyboard view to show
    /// to do it. You can customize any part of this view or
    /// replace it with a completely custom view if you want.
    override func viewWillSetupKeyboard() {
        super.viewWillSetupKeyboard()

        /// 💡 Make the demo use a standard ``KeyboardView``.
        setup { controller in
            KeyboardView(
                state: controller.state,
                services: controller.services,
                buttonContent: { $0.view },
                buttonView: { $0.view },
                emojiKeyboard: { $0.view },
                toolbar: { $0.view }
            )
            // .autocorrectionDisabled()
        }
    }
}
