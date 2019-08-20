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

    convenience init(word: String, proxy: UITextDocumentProxy) {
        self.init(frame: .zero)
        self.proxy = proxy
        text = word
        textAlignment = .center
        accessibilityTraits = .button
        textColor = textColor(for: proxy)
        addTapAction { [weak self] in
            self?.proxy?.replaceCurrentWord(with: word)
        }
    }
    
    private weak var proxy: UITextDocumentProxy?
}

private extension DemoAutocompleteLabel {
    
    func textColor(for proxy: UITextDocumentProxy) -> UIColor {
        let asset = proxy.keyboardAppearance == .dark
            ? Asset.Colors.darkButtonText
            : Asset.Colors.lightButtonText
        return asset.color
    }
}
