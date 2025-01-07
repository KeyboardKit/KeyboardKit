//
//  UITextDocumentProxy+Diacritics.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2024-04-12.
//  Copyright © 2024-2025 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit

public extension UITextDocumentProxy {
    
    /// Apply a certain diacritic.
    ///
    /// This will replace the character just before the text
    /// input cursor with a diacritic replacement, or insert
    /// the diacritic diaplay character if no match is found.
    func insertDiacritic(
        _ diacritic: Keyboard.Diacritic
    ) {
        let before = documentContextBeforeInput
        guard let last = before?.suffix(1) else { return }
        if let match = diacritic.replacements[String(last)] {
            deleteBackward()
            insertText(match)
        } else {
            insertText(diacritic.char)
        }
    }
}
#endif
