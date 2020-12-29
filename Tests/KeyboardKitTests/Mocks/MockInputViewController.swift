//
//  MockInputViewController.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import Mockery
import UIKit

class MockInputViewController: KeyboardInputViewController, Mockable {
    
    lazy var changeKeyboardTypeRef = MockReference(changeKeyboardType)
    lazy var dismissKeyboardRef = MockReference(dismissKeyboard)
    lazy var performAutocompleteRef = MockReference(performAutocomplete)
    
    let mock = Mock()
    
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
