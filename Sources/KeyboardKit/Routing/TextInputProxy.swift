//
//  TextInputProxy.swift
//  KeyboardKit
//
//  Original implementation by @wearhere
//  Source: https://gist.github.com/wearhere/f46ab9d837acaeaabfa86a813c44ad25
//
//  Created by Daniel Saidi on 2021-07-14.
//  Copyright © 2021-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

/**
 This class can be used to route text from an app to another
 text field, for instance in keyboard extension itself.

 This class implements `UITextDocumentProxy`, which lets you
 customize proxy-related features. The class also implements
 `UITextInputTraits`, which lets you customize input-related
 features and behaviors like the return button type. Finally,
 it implements `UIKeyInput` to handle text insert and delete.
 You can inherit and override this class to customize things
 further.
 
 If you use the ``KeyboardTextField`` and ``KeyboardTextView``
 views in your keyboard, they will automatically replace the
 standard document proxy with this type as long as they have
 focus, then switch back when they lose focus. If you are to
 implement your own custom text fields or proxies, check out
 these views for inspiration.
 */
open class TextInputProxy: NSObject, UITextDocumentProxy, UITextInputTraits {
    
    /**
     Create a text input proxy instance.
     
     - Parameter input: The input to use.
     */
    public init(input: TextInput) {
        self.input = input
        self.autocapitalizationType = input.autocapitalizationType ?? .none
        self.autocorrectionType = input.autocorrectionType ?? .default
        self.enablesReturnKeyAutomatically = input.enablesReturnKeyAutomatically ?? false
        self.isSecureTextEntry = input.isSecureTextEntry ?? false
        self.keyboardAppearance = input.keyboardAppearance ?? .default
        self.keyboardType = input.keyboardType ?? .default
        self.returnKeyType = input.returnKeyType ?? .default
        self.spellCheckingType = input.spellCheckingType ?? .default
        self.smartDashesType = input.smartDashesType ?? .default
        self.smartInsertDeleteType = input.smartInsertDeleteType ?? .default
        self.smartQuotesType = input.smartQuotesType ?? .default
        super.init()
    }
    
    public typealias TextInput = UIResponder & UITextInput
    
    private weak var input: TextInput?
    
    
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
    
    
    // MARK: - UITextDocumentProxy
    
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
    
    open var documentInputMode: UITextInputMode? { input?.textInputMode }
    
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
    
    
    // MARK: - UITextInputTraits
    
    public var autocapitalizationType: UITextAutocapitalizationType
    public var autocorrectionType: UITextAutocorrectionType
    public var enablesReturnKeyAutomatically: Bool
    public var keyboardAppearance: UIKeyboardAppearance
    public var keyboardType: UIKeyboardType
    public var returnKeyType: UIReturnKeyType
    public var isSecureTextEntry: Bool
    public var spellCheckingType: UITextSpellCheckingType
    public var smartDashesType: UITextSmartDashesType
    public var smartInsertDeleteType: UITextSmartInsertDeleteType
    public var smartQuotesType: UITextSmartQuotesType
}
#endif
