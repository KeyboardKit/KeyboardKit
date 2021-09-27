//
//  KeyboardInputTextComponent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-07-21.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This internal protocol is shared among the various keyboard
 input text views/fields, to share common behavior.
 */
protocol KeyboardInputTextComponent: UIResponder, UITextInput {
    
    var resignOnReturn: Bool { get }
}

extension KeyboardInputTextComponent {
    
    var viewController: KeyboardInputViewController {
        KeyboardInputViewController.shared
    }
    
    func handleBecomeFirstResponder() {
        viewController.textInputProxy = TextInputProxy(input: self)
    }
    
    func handleInsertText(_ text: String) -> Bool {
        guard resignOnReturn, text == "\n" else { return true }
        resignFirstResponder()
        return false
    }
    
    func handleResignFirstResponder() {
        viewController.textInputProxy = nil
    }
}
