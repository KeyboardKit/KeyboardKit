//
//  MockTextDocumentProxy.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2019-07-04.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import MockingKit
import UIKit

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
