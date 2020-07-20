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
    
    lazy var dismissKeyboardRef = MockReference(dismissKeyboard)
    
    let mock = Mock()
    
    override func dismissKeyboard() {
        invoke(dismissKeyboardRef, args: ())
    }
}
