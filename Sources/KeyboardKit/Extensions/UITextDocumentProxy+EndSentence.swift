//
//  UITextDocumentProxy+EndSentence.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2020-12-28.
//  Copyright © 2020 Daniel Saidi. All rights reserved.
//

import UIKit

public extension UITextDocumentProxy {
    
    func endSentence() {
        guard isCursorAtTheEndOfTheCurrentWord else { return }
        while (documentContextBeforeInput ?? "").hasSuffix(" ") {
            deleteBackward(times: 1)
        }
        insertText(". ")
    }
}
