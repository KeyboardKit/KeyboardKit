//
//  KeyboardInputComponent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-07-21.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

/**
 This protocol can be used to create text inputs that can be
 used within a keyboard extension.

 Views that inherits this protocol can use its functionality
 to register and unregister as the current text input proxy.
 
 The `KeyboardTextField` and `KeyboardTextView` views in Pro
 wrap `UIKit` views that implement this protocol.
 */
public protocol KeyboardInputComponent: UIResponder, UITextInput {

    /**
     Whether or not the text input should resign itself when
     the user taps return.
     
     If this is false, you must have another way to redirect
     the keyboard text input back to the main app. 
     */
    var resignOnReturn: Bool { get }

    /**
     The text input proxy to affect when this component gets
     and loses focus.
     */
    var controller: KeyboardInputViewController? { get set }
}

public extension KeyboardInputComponent {
    
    /**
     Call this when the input becomes the first responder.
     
     This will register the input as the current input proxy.
     */
    func handleBecomeFirstResponder() {
        DispatchQueue.main.async {
            self.controller?.textInputProxy = TextInputProxy(input: self)
        }
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
        controller?.textInputProxy = nil
    }
}
#endif
