//
//  UITextDocumentProxy+Content.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

public extension UITextDocumentProxy {

    /**
     Get the before and after document context combined.

     Note that for longer texts, this will most often not be
     the full content, since keyboard extensions get limited
     text back from the proxy. KeyboardKit Pro unlocks a way
     to read the full document context, so have a look at it
     if you need this functionality.
     */
    var documentContext: String? {
        let before = documentContextBeforeInput ?? ""
        let after = documentContextAfterInput ?? ""
        return before + after
    }
}
#endif
