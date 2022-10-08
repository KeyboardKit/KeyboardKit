//
//  UITextDocumentProxy+Content.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

public extension UITextDocumentProxy {

    /**
     Trimmed textual content after the text cursor.
     */
    var trimmedDocumentContextAfterInput: String? {
        documentContextAfterInput?.trimmed()
    }
    
    /**
     Trimmed textual content before the text cursor.
     */
    var trimmedDocumentContextBeforeInput: String? {
        documentContextBeforeInput?.trimmed()
    }
}
#endif
