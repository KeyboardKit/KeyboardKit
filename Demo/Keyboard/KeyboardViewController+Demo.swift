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

    /// This function is used by the keyboard controller, to
    /// set up demo-specific keyboard services.
    ///
    /// The `Keyboard` keyboard will use a fake autocomplete
    /// service, since it can't use KeyboardKit Pro services,
    /// and a demo callout service that returns `keyboardkit`
    /// actions for `k`. The `KeyboardPro` keyboard uses Pro
    /// services, but can be customized below.
    func setupDemoServices(
        extraKey: DemoLayoutService.ExtraKey
    ) {

        /// 💡 Set up a demo-specific action handler.
        services.actionHandler = DemoActionHandler(
            controller: self
        )

        #if IS_KEYBOARDKIT
        /// 💡 Set up a fake autocomplete service.
        services.autocompleteService = FakeAutocompleteService(
            context: state.autocompleteContext
        )
        
        /// 💡 Set up a demo-specific callout service that by
        /// default changes the `k` callout actions.
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
        services.styleProvider = DemoStyleProvider(
            keyboardContext: state.keyboardContext
        )
    }

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
