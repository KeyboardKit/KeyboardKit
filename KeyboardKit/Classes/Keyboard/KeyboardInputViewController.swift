//
//  KeyboardViewControllerBase.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2016-01-31.
//  Copyright © 2016 Daniel Saidi. All rights reserved.
//

/*
 
 TODO: Remove all unimplemented but required stuff and
 design it clearer.
 
 */

import UIKit

open class KeyboardInputViewController: UIInputViewController, KeyboardDelegate {

    
    // MARK: View lifecycle
    
    open override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    open override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupKeyboard()
    }
    
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        setupKeyboard()
    }
    
    open override func updateViewConstraints() {
        super.updateViewConstraints()
        setupKeyboard()
    }
    
    
    
    // MARK: Properties
    
    open var keyboard: Keyboard! {
        didSet { keyboard.delegate = self }
    }
    
    open var lastPageNumber: Int {
        get { return settings.integer(forKey: "lastPageNumber") }
        set { settings.set(keyboard.pageNumber, forKey: "lastPageNumber") }
    }
    
    open var openAccessEnabled: Bool {
        get { return UIPasteboard.general.isKind(of: UIPasteboard.self) }
    }
    
    open var settings: UserDefaults {
        get { return UserDefaults.standard }
    }
    
    
    
    // MARK: Public functions
    
    open func createKeyboard() -> Keyboard! {
        print("** WARNING! createKeyboard() not implemented in KeyboardInputViewController subclass **")
        return nil
    }
    
    open func setupKeyboard() {
        keyboard = createKeyboard()
        keyboard.setupKeyboard(in: self)
        keyboard.pageNumber = lastPageNumber
    }
    
    
    
    // MARK: KeyboardDelegate
    
    open func keyboard(_ keyboard: Keyboard, buttonLongPressed button: KeyboardButton) {
    }
    
    open func keyboard(_ keyboard: Keyboard, buttonTapped button: KeyboardButton) {
        if let _ = button.operation {
            switch (button.operation!) {
            case .backspace:
                textDocumentProxy.deleteBackward()
            case .nextKeyboard:
                advanceToNextInputMode()
            case .newLine:
                textDocumentProxy.insertText("\n")
            case .space:
                textDocumentProxy.insertText(" ")
            default:
                break
            }
        }
    }
    
    public func keyboardDidChangePageNumber(_ keyboard: Keyboard) {
        lastPageNumber = keyboard.pageNumber
        settings.synchronize()
    }
}
