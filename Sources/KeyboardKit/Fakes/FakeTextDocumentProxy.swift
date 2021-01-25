//
//  FakeTextDocumentProxy.swift
//  KeyboardKitTests
//
//  Created by Daniel Saidi on 2021-01-25.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This is a fake `UITextDocumentProxy`. It can be used when a
 proxy is needed, but it doesn't have to work.
 
 For instance, `SwiftUI` previews may require an instance to
 build, but the instance doesn't have to be real.
 */
public class FakeTextDocumentProxy: NSObject, UITextDocumentProxy {
    
    public var autocapitalizationType: UITextAutocapitalizationType = .none
    public var documentContextBeforeInput: String?
    public var documentContextAfterInput: String?
    public var hasText: Bool = false
    public var selectedText: String?
    public var documentInputMode: UITextInputMode?
    public var documentIdentifier: UUID = UUID()
    
    public func adjustTextPosition(byCharacterOffset offset: Int) {}
    public func deleteBackward() {}
    public func insertText(_ text: String) {}
    public func setMarkedText(_ markedText: String, selectedRange: NSRange) {}
    public func unmarkText() {}
}
