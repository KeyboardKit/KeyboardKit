//
//  MockTextDocumentProxy.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import Mockery
import UIKit

/**
 `IMPORTANT` The mocked `deleteBackward` function is somehow
 not building in Xcode 12, where `args: ()` must be replaced
 with `args: 0`. I'm not sure why this is needed since other
 non-arg functions work as before. Perhaps it is just a beta
 bug that will be solved later? I'll revisit this when Xcode
 12 is released.
 */
class MockTextDocumentProxy: NSObject, UITextDocumentProxy, Mockable {
    
    lazy var adjustTextPositionRef = MockReference(adjustTextPosition)
    lazy var deleteBackwardRef = MockReference(deleteBackward as () -> Void)
    lazy var insertTextRef = MockReference(insertText)
    lazy var setMarkedTextRef = MockReference(setMarkedText)
    lazy var unmarkTextRef = MockReference(unmarkText)
    
    let mock = Mock()
    
    var hasText: Bool = false
    
    var autocapitalizationType: UITextAutocapitalizationType = .none
    var documentContextBeforeInput: String?
    var documentContextAfterInput: String?
    var selectedText: String?
    var documentInputMode: UITextInputMode?
    var documentIdentifier: UUID = UUID()
    
    func adjustTextPosition(byCharacterOffset offset: Int) {
        invoke(adjustTextPositionRef, args: (offset))
    }
    
    func deleteBackward() {
        documentContextBeforeInput?.removeLast()
        invoke(deleteBackwardRef, args: ())
    }
    
    func insertText(_ text: String) {
        invoke(insertTextRef, args: (text))
    }
    
    func setMarkedText(_ markedText: String, selectedRange: NSRange) {
        invoke(setMarkedTextRef, args: (markedText, selectedRange))
    }
    
    func unmarkText() {
        invoke(unmarkTextRef, args: ())
    }
}
