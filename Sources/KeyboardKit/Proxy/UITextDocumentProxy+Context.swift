//
//  UITextDocumentProxy+Content.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

public extension UITextDocumentProxy {

    /// Get the document context before and after the input.
    ///
    /// Note that this property will most often not give you
    /// the entire text, since keyboard extensions only have
    /// limited access to the document.
    ///
    /// Any new paragraph in the text may cause the keyboard
    /// to stop looking for more content.
    ///
    /// KeyboardKit Pro unlocks ways to read the entire text
    /// from the current document.
    var documentContext: String? {
        let before = documentContextBeforeInput ?? ""
        let after = documentContextAfterInput ?? ""
        return before + after
    }
    
    /// Whether the proxy is currently reading the full text
    /// from the current document.
    ///
    /// These full document context reading capabilities are
    /// available as an add-on in KeyboardKit Pro.
    var isReadingFullDocumentContext: Bool {
        get { FullDocumentContextReaderState.isReadingFullDocumentContext }
        set { FullDocumentContextReaderState.isReadingFullDocumentContext = newValue }
    }
}
#endif
