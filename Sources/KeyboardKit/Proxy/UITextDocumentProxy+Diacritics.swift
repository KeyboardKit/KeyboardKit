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
    
    /// Insert a diacritic and perform matching replacements.
    func insertDiacritic(
        _ diacritic: Keyboard.Diacritic
    ) {
        let before = documentContextBeforeInput ?? ""
        let result = diacritic.insertionResult(whenAppendedTo: before)
        deleteBackward(times: result.deleteBackwardsCount)
        insertText(result.textInsertion)
    }
}
#endif
