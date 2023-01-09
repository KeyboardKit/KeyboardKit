//
//  KeyboardInputComponent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-07-21.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

/**
 This protocol can be used to create text inputs that can be
 used within a keyboard extension.

 A view that inherits this protocol can use its functions to
 easily register and unregister itself as the proxy.

 ``KeyboardTextField`` and ``KeyboardTextView`` implement it
 to let you edit text within a keyboard extension. They both
 set themselves as the current text document proxy when they
 have focus, and reset it when the focus is lost.
 */
public protocol KeyboardInputComponent: UIResponder, UITextInput {
    
    /**
     Whether or not the text input should resign itself when
     the user taps return.
     
     If this is set to `false`, you must provide another way
     to redirect the keyboard extension back to the main app,
     which is done with `viewController.textInputProxy = nil`.
     */
    var resignOnReturn: Bool { get }
}

public extension KeyboardInputComponent {
    
    /**
     The currently active input view controller.
     */
    var viewController: KeyboardInputViewController {
        KeyboardInputViewController.shared
    }
    
    /**
     Call this when the input becomes the first responder.
     
     This will register the input as the current input proxy.
     */
    func handleBecomeFirstResponder() {
        viewController.textInputProxy = TextInputProxy(input: self)
    }
    
    /**
     Call this whenever text is inserted into the input.
     
     If `resignOnReturn` is true and the `text` is `\n`, the
     text input will automatically resign as first responder.
     This will redirect the keyboard to the main application.
     */
    func handleInsertText(_ text: String) -> Bool {
        guard resignOnReturn, text == "\n" else { return true }
        resignFirstResponder()
        return false
    }
    
    /**
     Call this when the input resigns as first responder.
     
     This will remove the input from the current input proxy.
     */
    func handleResignFirstResponder() {
        viewController.textInputProxy = nil
    }
}
#endif
