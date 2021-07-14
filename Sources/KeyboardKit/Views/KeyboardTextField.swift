//
//  KeyboardTextField.swift
//  KeybaordKit
//
//  Created by Daniel Saidi on 2021-07-15.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import SwiftUI
import UIKit

/**
 This view can be used within a keyboard extension, when you
 want to provide a single-line text field next to a keyboard
 and have that receive user input instead of the hosting app.
 
 The view will automatically register itself as an alternate
 proxy when it becomes first responder and unregister itself
 when it resigns first responder. This makes it receive user
 actions instead of the hosting app.
 */
public struct KeyboardTextField: UIViewRepresentable {
    
    /**
     Create a keyboard text field instance.
     
     - Parameters:
       - resignOnReturn: Whether or not to resign first responder when return is pressed.
       - config: A configuration block that can be used to configure the text field.
     */
    public init(
        resignOnReturn: Bool = true,
        config: @escaping ConfigAction = { _ in }) {
        self.config = config
        self.resignOnReturn = resignOnReturn
    }
    
    private let config: ConfigAction
    private let resignOnReturn: Bool
    
    public typealias ConfigAction = (UITextField) -> Void
    
    public func makeUIView(context: Context) -> UITextField {
        let textField = KeyboardInputTextField()
        textField.resignOnReturn = resignOnReturn
        config(textField)
        return textField
    }
    
    public func updateUIView(_ uiView: UITextField, context: Context) {}
}

class KeyboardInputTextField: UITextField {
    
    var resignOnReturn: Bool = true
    
    override func insertText(_ text: String) {
        if resignOnReturn && text == "\n" {
            _ = resignFirstResponder()
            return
        }
        super.insertText(text)
    }
    
    override func becomeFirstResponder() -> Bool {
        KeyboardInputViewController.shared.textInputProxy = TextInputProxy(input: self)
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        KeyboardInputViewController.shared.textInputProxy = nil
        return super.resignFirstResponder()
    }
}
