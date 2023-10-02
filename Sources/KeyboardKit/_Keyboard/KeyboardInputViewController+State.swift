//
//  KeyboardInputViewController+State.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-10-02.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
public extension KeyboardInputViewController {
    
    /// The ``keyboardState`` autocomplete context.
    var autocompleteContext: AutocompleteContext { keyboardState.autocompleteContext }
    
    /// The ``keyboardState`` callout context.
    var calloutContext: CalloutContext { keyboardState.calloutContext }
    
    /// The ``keyboardState`` dictation context.
    var dictationContext: DictationContext { keyboardState.dictationContext }
    
    /// The ``keyboardState`` feedback configuration.
    var feedbackConfiguration: FeedbackConfiguration { keyboardState.feedbackConfiguration }
    
    /// The ``keyboardState`` keyboard context.
    var keyboardContext: KeyboardContext { keyboardState.keyboardContext }
    
    /// The ``keyboardState`` keyboard text context.
    var keyboardTextContext: KeyboardTextContext { keyboardState.keyboardTextContext }
}
#endif
