//
//  MockTextDocumentProxy.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2021-03-18.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import MockingKit
import UIKit

/**
 This class can be used as a mocked `UITextDocumentProxy`.
 */
open class MockTextDocumentProxy: NSObject, UITextDocumentProxy, Mockable {
    
    public lazy var adjustTextPositionRef = MockReference(adjustTextPosition)
    public lazy var deleteBackwardRef = MockReference(deleteBackward as () -> Void)
    public lazy var insertTextRef = MockReference(insertText)
    public lazy var setMarkedTextRef = MockReference(setMarkedText)
    public lazy var unmarkTextRef = MockReference(unmarkText)
    
    public let mock = Mock()
    
    public var hasText: Bool = false
    
    public var autocapitalizationType: UITextAutocapitalizationType = .none
    public var documentContextBeforeInput: String?
    public var documentContextAfterInput: String?
    public var documentIdentifier: UUID = UUID()
    public var documentInputMode: UITextInputMode?
    public var keyboardAppearance: UIKeyboardAppearance = .light
    public var selectedText: String?
    
    public func adjustTextPosition(byCharacterOffset offset: Int) {
        call(adjustTextPositionRef, args: (offset))
    }
    
    public func deleteBackward() {
        let preCount = documentContextBeforeInput?.count ?? 0
        if preCount > 0 { documentContextBeforeInput?.removeLast() }
        call(deleteBackwardRef, args: ())
    }
    
    public func insertText(_ text: String) {
        call(insertTextRef, args: (text))
    }
    
    public func setMarkedText(_ markedText: String, selectedRange: NSRange) {
        call(setMarkedTextRef, args: (markedText, selectedRange))
    }
    
    public func unmarkText() {
        call(unmarkTextRef, args: ())
    }
}
#endif
