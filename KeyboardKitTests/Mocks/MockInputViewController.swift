//
//  MockInputViewController.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import MockNRoll

class MockInputViewController: UIInputViewController {
    
    private let recorder = Mock()
    
    override func dismissKeyboard() {
        recorder.invoke(dismissKeyboard, args: ())
    }
}
