//
//  KeyboardViewController+Demo.swift
//  Demo
//
//  Created by Daniel Saidi on 2024-08-27.
//  Copyright © 2024 Daniel Saidi. All rights reserved.
//

#if IS_KEYBOARDKIT
import KeyboardKit
#elseif IS_KEYBOARDKITPRO
import KeyboardKitPro
#endif

extension KeyboardViewController {

    /// This is used by both keyboard controllers, to set up
    /// demo-specific keyboard services.
    ///
    /// You can play around with these services and register
    /// your own services to see how it affects the keyboard.
    func setupDemoServices(
        extraKey: DemoLayoutService.ExtraKey
    ) {

        /// 💡 Set up a demo-specific action handler.
        services.actionHandler = DemoActionHandler(
            controller: self
        )

        #if IS_KEYBOARDKIT
        /// 💡 Setup a demo-specific autocomplete service to
        /// provide the `Keyboard` keyboard with dummy words.
        services.autocompleteService = FakeAutocompleteService(
            context: state.autocompleteContext
        )
        
        /// 💡 Setup a demo-specific callout service that is
        /// adding some dummy actions to the `k` key.
        services.calloutService = Callouts.StandardService(
            keyboardContext: state.keyboardContext,
            baseService: DemoCalloutService()
        )
        #endif

        /// 💡 Setup a demo-specific keyboard layout service
        /// that inserts an additional key into the keyboard.
        services.layoutService = DemoLayoutService(
            extraKey: extraKey
        )

        /// 💡 Setup a demo-specific keyboard style that can
        /// change the design of any keys in a keyboard view.
        services.styleService = DemoStyleService(
            keyboardContext: state.keyboardContext
        )
    }

    /// This is used by both keyboard controllers, to set up
    /// demo-specific keyboard state.
    ///
    /// You can play around with the various state types, to
    /// see how it affects the keyboard.
    func setupDemoState() {

        /// 💡 Set up which locale to use to present locales.
        state.keyboardContext.localePresentationLocale = .current

        /// 💡 Configure the space key's long press behavior.
        state.keyboardContext.spaceLongPressBehavior = .moveInputCursor
        // state.keyboardContext.spaceLongPressBehavior = .openLocaleContextMenu

        /// 💡 Disable autocorrection.
        // state.autocompleteContext.isAutocorrectEnabled = false
        
        /// 💡 Setup demo-specific haptic & audio feedback.
        let feedback = state.feedbackContext
        feedback.registerCustomFeedback(.haptic(.selection, for: .repeat, on: .rocket))
        feedback.registerCustomFeedback(.audio(.rocketFuse, for: .press, on: .rocket))
        feedback.registerCustomFeedback(.audio(.rocketLaunch, for: .release, on: .rocket))
    }
}
