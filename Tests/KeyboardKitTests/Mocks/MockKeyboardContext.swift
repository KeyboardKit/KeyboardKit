//
//  MockKeyboardContext.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-07-02.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import Foundation
import MockingKit
import UIKit
@testable import KeyboardKit

class MockKeyboardContext: KeyboardContext {
    
    public init(device: UIDevice = .current) {
        super.init(
            locale: .current,
            device: device,
            controller: MockKeyboardInputViewController(),
            keyboardType: .alphabetic(.lowercased))
    }
}
