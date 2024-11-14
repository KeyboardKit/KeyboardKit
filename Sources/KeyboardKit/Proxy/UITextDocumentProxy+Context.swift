//
//  UITextDocumentProxy+Content.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020-2024 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit

public extension UITextDocumentProxy {

    /// Get the document context (the text) before and after
    /// the input cursor.
    ///
    /// This property does not return the full document text.
    /// A keyboard extension has limited document access and
    /// can stop looking for more text at any time.
    ///
    /// KeyboardKit Pro unlocks ways to read the entire text
    /// from a document. See the <doc:Proxy-Article> article
    /// for more information.
    var documentContext: String? {
        let before = documentContextBeforeInput ?? ""
        let after = documentContextAfterInput ?? ""
        return before + after
    }
    
    /// Whether the proxy is currently reading the full text
    /// from the current document.
    ///
    /// KeyboardKit Pro unlocks ways to read the entire text
    /// from a document. See the <doc:Proxy-Article> article
    /// for more information. 
    var isReadingFullDocumentContext: Bool {
        get { FullDocumentContextReaderState.isReadingFullDocumentContext }
        set { FullDocumentContextReaderState.isReadingFullDocumentContext = newValue }
    }
}
#endif
