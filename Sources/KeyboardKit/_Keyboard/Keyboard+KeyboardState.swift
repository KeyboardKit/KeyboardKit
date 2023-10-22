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
     
     > Important: Only use the class as a transfer mechanism,
     to simplify passing all services used by a keyboard.
     */
    class KeyboardState {
        
        /// The autocomplete context to use.
        public lazy var autocompleteContext = AutocompleteContext()
        
        /// The callout context to use.
        public lazy var calloutContext = CalloutContext(
            actionContext: .disabled,
            inputContext: .disabled)
        
        /// The dictation configuration to use.
        public lazy var dictationConfig = Dictation.KeyboardConfiguration(
            context: dictationContext)
        
        /// The dictation context to use.
        public lazy var dictationContext = DictationContext()
        
        /// The feedback context to use.
        public lazy var feedbackConfiguration = FeedbackConfiguration()
        
        /// The keyboard context to use.
        public lazy var keyboardContext = KeyboardContext()
    }
}

#if os(iOS) || os(tvOS)
public extension Keyboard.KeyboardState {
    
    func setup(for controller: KeyboardInputViewController) {
        let isPhone = UIDevice.current.userInterfaceIdiom == .phone
        keyboardContext.sync(with: controller)
        calloutContext.inputContext.isEnabled = isPhone
    }
}
#endif

public extension View {
    
    func withEnvironment(from state: Keyboard.KeyboardState) -> some View {
        self.environmentObject(state.autocompleteContext)
            .environmentObject(state.calloutContext)
            .environmentObject(state.dictationContext)
            .environmentObject(state.feedbackConfiguration)
            .environmentObject(state.keyboardContext)
    }
}
