//
//  KeyboardViewController+DemoServices.swift
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
    /// as well as a demo-specific callout service that will
    /// present `keyboardkit` actions for the `k` key. These
    /// services are not used by the `KeyboardPro` keyboard.
    func setupDemoServices() {

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

        #if IS_KEYBOARDKIT
        let extraKey = DemoLayoutService.ExtraKey.rocket
        #elseif IS_KEYBOARDKITPRO
        let extraKey = DemoLayoutService.ExtraKey.emojiIfNeeded
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
}
