//
//  TextInputProxy.swift
//  KeyboardKit
//
//  Original implementation by @wearhere
//  Source: https://gist.github.com/wearhere/f46ab9d837acaeaabfa86a813c44ad25
//
//  Created by Daniel Saidi on 2021-07-14.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This class implements `UITextDocumentProxy` and can be used
 to use anything that implements `UIResponder & UITextInput`
 as a text document.
 */
open class TextInputProxy: NSObject, UITextDocumentProxy {
    
    /**
     Create a text input proxy instance.
     
     - Parameter input: The input to use.
     */
    public init(input: TextInput) {
        self.input = input
        self.autocapitalizationType = input.autocapitalizationType ?? .none
        super.init()
    }
    
    
    public typealias TextInput = UIResponder & UITextInput
    
    private weak var input: TextInput?
    
    
    // MARK: - UITextDocumentProxy
    
    public var autocapitalizationType: UITextAutocapitalizationType
    
    open var documentContextAfterInput: String? {
        guard
            let input = input,
            let selectedRange = input.selectedTextRange,
            let rangeAfterInput = input.textRange(from: selectedRange.end, to: input.endOfDocument)
        else { return nil }
        return input.text(in: rangeAfterInput)
    }
    
    open var documentContextBeforeInput: String? {
        guard
            let input = input,
            let selectedRange = input.selectedTextRange,
            let rangeBeforeInput = input.textRange(from: input.beginningOfDocument, to: selectedRange.start)
        else { return nil }
        return input.text(in: rangeBeforeInput)
    }
    
    public let documentIdentifier = UUID()
    
    open var documentInputMode: UITextInputMode? {
        input?.textInputMode
    }
    
    open var selectedText: String? {
        guard
            let input = input,
            let selectedTextRange = input.selectedTextRange
        else { return nil }
        return input.text(in: selectedTextRange)
    }
    
    /**
     Adjust the text position by a certain offset.
     
     https://stackoverflow.com/a/41023439/495611 suggests us
     to adjust the text position (i.e. moving the cursor) by
     adjusting the selected text range.
     */
    open func adjustTextPosition(byCharacterOffset offset: Int) {
        guard
            let input = input,
            let selectedTextRange = input.selectedTextRange,
            let newPosition = input.position(from: selectedTextRange.start, offset: offset)
        else { return }
        input.selectedTextRange = input.textRange(from: newPosition, to: newPosition)
    }
    
    open func setMarkedText(_ markedText: String, selectedRange: NSRange) {
        input?.setMarkedText(markedText, selectedRange: selectedRange)
    }
    
    open func unmarkText() {
        input?.unmarkText()
    }
    
    
    // MARK: - UIKeyInput
    
    open var hasText: Bool {
        input?.hasText ?? false
    }
    
    open func insertText(_ text: String) {
        input?.insertText(text)
    }
    
    open func deleteBackward() {
        input?.deleteBackward()
    }
}
