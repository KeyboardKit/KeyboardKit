//
//  Keyboard+KeyboardState.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-10-02.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {

    /**
     This type is used to retain keyboard state instances.
     
     This lets us decouple the primary input controller from
     any views that require many properties from it. You can
     configure the state instances at any time.
     
     Instead of passing the entire controller instance, pass
     in ``KeyboardInputViewController/state``.
     
     > Important: Only use the class as a transfer mechanism.
     Never store instance of it, but copy any properties you
     need and/or pass it on. Storing instances can lead to a
     reference cycle and memory leaks.
     */
    class KeyboardState {
        
        /// The observable autocomplete context to use.
        public lazy var autocompleteContext = AutocompleteContext()
        
        /// The observable callout context to use.
        public lazy var calloutContext = CalloutContext(
            actionContext: .disabled,
            inputContext: .disabled)
        
        /// The observable dictation context to use.
        public lazy var dictationContext = DictationContext()
        
        /// The observable feedback context to use.
        public lazy var feedbackConfiguration = FeedbackConfiguration()
        
        /// The observable keyboard context to use.
        public lazy var keyboardContext = KeyboardContext()
        
        /// The observable keyboard text context to use.
        public lazy var keyboardTextContext = KeyboardTextContext()
    }
}

public extension View {
    
    func withEnvironment(from state: Keyboard.KeyboardState) -> some View {
        self.environmentObject(state.autocompleteContext)
            .environmentObject(state.calloutContext)
            .environmentObject(state.dictationContext)
            .environmentObject(state.feedbackConfiguration)
            .environmentObject(state.keyboardContext)
            .environmentObject(state.keyboardTextContext)
    }
}
