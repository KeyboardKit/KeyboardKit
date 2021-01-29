//
//  MockInputViewController.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import MockingKit
import UIKit

class MockInputViewController: KeyboardInputViewController, Mockable {
    
    lazy var changeKeyboardTypeRef = MockReference(changeKeyboardType)
    lazy var dismissKeyboardRef = MockReference(dismissKeyboard)
    lazy var performAutocompleteRef = MockReference(performAutocomplete)
    
    let mock = Mock()
    
    var textDocumentProxyReplacement: UITextDocumentProxy?
    
    override var textDocumentProxy: UITextDocumentProxy { textDocumentProxyReplacement ?? super.textDocumentProxy }
    
    override func changeKeyboardType(to type: KeyboardType) {
        invoke(changeKeyboardTypeRef, args: (type))
    }
    
    override func dismissKeyboard() {
        invoke(dismissKeyboardRef, args: ())
    }
    
    override func performAutocomplete() {
        invoke(performAutocompleteRef, args: ())
    }
}
