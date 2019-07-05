//
//  DemoAutocompleteLabel.swift
//  KeyboardKitExampleKeyboard
//
//  Created by Daniel Saidi on 2019-07-05.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit
import KeyboardKit

class DemoAutocompleteLabel: UILabel {

    convenience init(word: String, textDocumentProxy: UITextDocumentProxy) {
        self.init(frame: .zero)
        self.proxy = textDocumentProxy
        accessibilityTraits = .button
        text = word
        addTapAction { [weak self] in
            self?.proxy?.replaceCurrentWord(with: word)
        }
    }
    
    private weak var proxy: UITextDocumentProxy?
}
