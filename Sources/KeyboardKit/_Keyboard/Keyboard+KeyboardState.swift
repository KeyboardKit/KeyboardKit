//
//  Keyboard+KeyboardState.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2023-10-02.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

public extension Keyboard {

    /**
     This type is used to retain keyboard state instances.
     
     This lets us decouple an input controller from any view
     that requires many state properties from it.
     
     Instead of passing the entire controller instance, pass
     in ``KeyboardInputViewController/keyboardState``.
     
     You can configure the state properties at any time. The
     ``KeyboardInputViewController`` will for instance setup
     the ``calloutContext`` to use its services.
     */
    class KeyboardState {
        
        /**
         An observable autocomplete context.
         
         This can be used as the overall state of a keyboard
         autocomplete feature.
         */
        public lazy var autocompleteContext = AutocompleteContext()
        
        /**
         An observable callout context.
         
         This can be used as the overall state of a keyboard
         with input and callout actions.
         */
        public lazy var calloutContext = CalloutContext(
            actionContext: .disabled,
            inputContext: .disabled)
        
        /**
         An observable dictation context.

         This can be used as the overall state of a keyboard
         dictation feature.
         */
        public lazy var dictationContext = DictationContext()
        
        /**
         An observable feedback context.

         This can be used as the overall configuration for a
         keyboard extension's feedback behavior.
         */
        public lazy var feedbackConfiguration = FeedbackConfiguration()
        
        /**
         An observable keyboard context.

         This can be used as the overall state of a keyboard
         and defines things like locale, device, etc.
         */
        public lazy var keyboardContext = KeyboardContext()
        
        /**
         An observable keyboard text context.

         This can be used to observe the ``textDocumentProxy``
         of a keyboard controller.
         */
        public lazy var keyboardTextContext = KeyboardTextContext()
    }
}
