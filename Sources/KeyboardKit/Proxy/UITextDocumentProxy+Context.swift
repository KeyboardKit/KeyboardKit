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

    /// Get the document context (the text) before and after
    /// the input cursor.
    ///
    /// It's important to note that this does NOT return the
    /// full document text. A keyboard extension has limited
    /// access to the document, and any new paragraph in the
    /// text may cause it to stop looking for more text.
    ///
    /// KeyboardKit Pro therefore unlocks additional ways to
    /// read the entire text from a document. Take a look at
    /// the <doc:Proxy-Article> article for more information.
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
