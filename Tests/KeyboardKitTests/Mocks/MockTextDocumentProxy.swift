//
//  MockTextDocumentProxy.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Mockery
import UIKit

class MockTextDocumentProxy: NSObject, UITextDocumentProxy, Mockable {
    
    lazy var adjustTextPositionRef = MockReference(adjustTextPosition)
    lazy var deleteBackwardRef = MockReference(deleteBackward)
    lazy var insertTextRef = MockReference(insertText)
    
    let mock = Mock()
    
    var hasText: Bool = false
    
    var documentContextBeforeInput: String?
    var documentContextAfterInput: String?
    var selectedText: String?
    var documentInputMode: UITextInputMode?
    var documentIdentifier: UUID = UUID()
    
    func adjustTextPosition(byCharacterOffset offset: Int) {
        invoke(adjustTextPositionRef, args: (offset))
    }
    
    func deleteBackward() {
        invoke(deleteBackwardRef, args: ())
    }
    
    func insertText(_ text: String) {
        invoke(insertTextRef, args: (text))
    }
    
    func setMarkedText(_ markedText: String, selectedRange: NSRange) {}
    
    func unmarkText() {}
}
