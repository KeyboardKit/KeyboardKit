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
     
     This lets us decouple the primary input controller from
     any views that require many properties from it. You can
     configure or replace the services instances at any time.
     
     Instead of passing the entire controller instance, pass
     in ``KeyboardInputViewController/services``.
     
     > Important: Only use the class as a transfer mechanism.
     Never store instance of it, but copy any properties you
     need and/or pass it on. Storing instances can lead to a
     reference cycle and memory leaks.
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
        
        
        /// The action handler to use.
        public lazy var actionHandler: KeyboardActionHandler = .preview {
            didSet { onContextAffectingServicesChanged() }
        }
        
        /// The autocomplete provider to use.
        public lazy var autocompleteProvider: AutocompleteProvider = .disabled
        
        /// The callout action provider to use.
        public lazy var calloutActionProvider: CalloutActionProvider = StandardCalloutActionProvider(
            keyboardContext: state.keyboardContext
        ) {
            didSet { onContextAffectingServicesChanged() }
        }
        
        /// The dictation service to use.
        public lazy var dictationService: KeyboardDictationService = .disabled(
            context: state.dictationContext
        )
        
        /// The keyboard behavior to use.
        public lazy var keyboardBehavior: KeyboardBehavior = StandardKeyboardBehavior(
            keyboardContext: state.keyboardContext)
        
        /// The keyboard layout provider to use.
        public lazy var layoutProvider: KeyboardLayoutProvider = StandardKeyboardLayoutProvider()
        
        /// The space drag gesture handler to use.
        public lazy var spaceDragGestureHandler = Gestures.SpaceDragGestureHandler(
            sensitivity: .medium,
            action: { _ in }
        )
        
        /// The keyboard style provider to use.
        public lazy var styleProvider: KeyboardStyleProvider = StandardKeyboardStyleProvider(
            keyboardContext: state.keyboardContext)
    }
}
