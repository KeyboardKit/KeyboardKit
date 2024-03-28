//
//  Keyboard+States.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-10-02.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Keyboard {

    /// This type specifies global keyboard state.
    ///
    /// This lets us decouple the input view controller from
    /// any views that require its states and services. This
    /// reduces the risk of memory leaks.
    ///
    /// You can adjust any state value at any time to adjust
    /// the global behavior of the keyboard.
    class State {
        
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

#if os(iOS) || os(tvOS) || os(visionOS)
public extension Keyboard.State {
    
    // Setup the state instance for the provided controller.
    func setup(for controller: KeyboardInputViewController) {
        let isPhone = UIDevice.current.userInterfaceIdiom == .phone
        keyboardContext.sync(with: controller)
        calloutContext.inputContext.isEnabled = isPhone
    }
}
#endif

public extension View {
    
    // Inject all observable state into the view hierarchy.
    func keyboardState(_ state: Keyboard.State) -> some View {
        self.environmentObject(state.autocompleteContext)
            .environmentObject(state.calloutContext)
            .environmentObject(state.dictationContext)
            .environmentObject(state.feedbackConfiguration)
            .environmentObject(state.keyboardContext)
    }
}
