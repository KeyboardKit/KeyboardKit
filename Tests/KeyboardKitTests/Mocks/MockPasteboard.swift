//
//  MockPasteboard.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-05-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit
import MockingKit

class MockPasteboard: UIPasteboard, Mockable {
    
    lazy var setDataRef = MockReference(setData)

    let mock = Mock()
    
    override func setData(_ data: Data, forPasteboardType pasteboardType: String) {
        invoke(setDataRef, args: (data, pasteboardType))
    }
}
