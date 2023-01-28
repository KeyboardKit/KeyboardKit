//
//  UITextDocumentProxy+Sentences.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS) || os(tvOS)
import UIKit

public extension UITextDocumentProxy {

    /**
     Check if the text input cursor is at the start of a new
     sentence, with or without trailing whitespace.
     */
    var isCursorAtNewSentence: Bool {
        documentContextBeforeInput?.isLastSentenceEnded ?? true
    }

    /**
     Check if the text input cursor is at the start of a new
     sentence, with trailing whitespace.
     */
    var isCursorAtNewSentenceWithTrailingWhitespace: Bool {
        documentContextBeforeInput?.isLastSentenceEndedWithTrailingWhitespace ?? true
    }

    /**
     The last ended sentence right before the cursor, if any.
     */
    var sentenceBeforeInput: String? {
        documentContextBeforeInput?.lastSentence
    }

    /**
     A list of western sentence delimiters.

     See the ``KeyboardCharacterProvider`` documentation for
     information on how to modify this delimiter collection.
     */
    var sentenceDelimiters: [String] {
        String.sentenceDelimiters
    }

    /**
     End the current sentence by removing all trailing space
     characters, then injecting a dot and a space.
     */
    func endSentence() {
        guard isCursorAtTheEndOfTheCurrentWord else { return }
        while (documentContextBeforeInput ?? "").hasSuffix(" ") {
            deleteBackward(times: 1)
        }
        insertText(". ")
    }
}
#endif
