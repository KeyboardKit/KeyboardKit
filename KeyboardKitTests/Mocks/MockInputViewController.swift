//
//  MockInputViewController.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-06.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import MockNRoll

class MockInputViewController: Mock {}

class MockInputViewControllerWrapper: UIInputViewController {
    
    init(mock: MockInputViewController) {
        self.mock = mock
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    private let mock: MockInputViewController
    
    override func dismissKeyboard() {
        mock.invoke(dismissKeyboard, args: ())
    }
}
