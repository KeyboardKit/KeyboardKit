//
//  MockKeyboardInputViewController.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import Mockery

class MockKeyboardInputViewController: KeyboardInputViewController {
    
    var recorder = Mock()
    
    override func addKeyboardGestures(to button: KeyboardButton) {
        recorder.invoke(addKeyboardGestures, args: (button))
    }
}
