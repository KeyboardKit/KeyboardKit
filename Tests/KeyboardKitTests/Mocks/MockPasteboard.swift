//
//  MockPasteboard.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit
import Mockery

class MockPasteboard: UIPasteboard {

    let recorder = Mock()
    
    override func setData(_ data: Data, forPasteboardType pasteboardType: String) {
        recorder.invoke(setData, args: (data, pasteboardType))
    }
}
