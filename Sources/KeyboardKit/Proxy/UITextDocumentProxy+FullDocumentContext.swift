//
//  UITextDocumentProxy+FullDocumentContext.swift
//  KeyboardKitPro
//
//  Created by Daniel Saidi on 2022-10-01.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Foundation
import UIKit

public extension UITextDocumentProxy {

    /**
     Whether or not this proxy is currently reading the full
     document context.

     The full document context reading capabilities are only
     available in KeyboardKit Pro.
     */
    var isReadingFullDocumentContext: Bool {
        get { FullDocumentContextReaderState.isReadingFullDocumentContext }
        set { FullDocumentContextReaderState.isReadingFullDocumentContext = newValue }
    }
}
#endif
