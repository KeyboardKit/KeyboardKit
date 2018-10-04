//
//  MockKeyboardPresenter.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2018-10-04.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import KeyboardKit

class MockKeyboardPresenter: KeyboardPresenter {
    
    init(id: String? = nil) {
        self.id = id
    }
    
    var id: String?
}
