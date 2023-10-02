//
//  Keyboard+KeyboardServices.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-10-02.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Keyboard {

    /**
     This type is used to retain keyboard service instances.
     
     This lets us decouple an input controller from any view
     that requires many service properties from it.
     
     Instead of passing the entire controller instance, pass
     in ``KeyboardInputViewController/keyboardServices``.
     */
    class KeyboardServices {
        
        /**
         Create an instance for the provided keyboard state.
         
         The action block will be called when a service that
         is used within any context is changed. The function
         should then update the context accordingly.
         
         - Parameters:
           - state: The state to base the services on.
           - onContextAffectingServicesChanged: A function to call to update contexts with new services, by default none.
         */
        public init(
            state: KeyboardState,
            onContextAffectingServicesChanged: @escaping () -> Void = {}
        ) {
            self.state = state
            self.onContextAffectingServicesChanged = onContextAffectingServicesChanged
        }
        
        
        /// The state to base the services on.
        private let state: KeyboardState
        
        /// A function to call to update contexts with new services, by default none.
        private let onContextAffectingServicesChanged: () -> Void
        
        
        /**
         The autocomplete provider to use.
         
         This is used to provide autocomplete suggestions as
         the text document proxy text is changed.
         
         This uses a `.disabled` instance until you register
         a custom one or activate KeyboardKit Pro.
         */
        public lazy var autocompleteProvider: AutocompleteProvider = .disabled
        
        /**
         The callout action provider to use.
         
         This is used to provide secondary actions when keys
         that have secondary actions are long pressed.
         */
        public lazy var calloutActionProvider: CalloutActionProvider = StandardCalloutActionProvider(
            keyboardContext: state.keyboardContext
        ) {
            didSet { onContextAffectingServicesChanged() }
        }
        
        /**
         The dictation service to use.
         
         This is used to perform dictation within a keyboard
         extension, which will open the main app.
         
         This uses a `.disabled` instance until you register
         a custom one or activate KeyboardKit Pro.
         */
        public lazy var dictationService: KeyboardDictationService = .disabled(
            context: state.dictationContext
        )
        
        /**
         The keyboard behavior to use.
         
         This is used to determine how a keyboard behaves in
         certain situations.
         
         > Important: When you replace the standard behavior
         with a custom one, do so before using services that
         depend on it. Otherwise, you must manually recreate
         those services when changing this behavior.
         */
        public lazy var keyboardBehavior: KeyboardBehavior = StandardKeyboardBehavior(
            keyboardContext: state.keyboardContext)
        
        /**
         The keyboard layout provider to use.
         
         This is used to provide a keyboard layout that will
         be loaded into the keyboard.
         */
        public lazy var layoutProvider: KeyboardLayoutProvider = StandardKeyboardLayoutProvider()
        
        /**
         The space cursor drag gesture handler to use.
         
         This is used to handle drag gestures on a space key
         in the keyboard view.
         */
        public lazy var spaceDragGestureHandler = Gestures.SpaceDragGestureHandler(
            sensitivity: .medium,
            action: { _ in }
        )
        
        /**
         The keyboard style provider to use.
         
         This is used to provide various keyboard styles for
         the keyboard.
         */
        public lazy var styleProvider: KeyboardStyleProvider = StandardKeyboardStyleProvider(
            keyboardContext: state.keyboardContext)
    }
}
