//
//  AutocompleteToolbar.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-02.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import CoreGraphics
import UIKit

/**
 This toolbar can be used to present autocomplete suggestion
 words while the user types.
 
 Since the `buttonCreator` parameter can return any view for
 any string, you can use this class to present any views you
 want, given any custom list of words.
 */
public class AutocompleteToolbar: KeyboardToolbar {

    /**
     Create an autocomplete toolbar that uses standard label
     classes of type `AutocompleteToolbarLabel` to provide a
     way to send suggestions to a `UITextDocumentProxy`.
     */
    public convenience init(
        height: CGFloat = .standardKeyboardRowHeight,
        textDocumentProxy: UITextDocumentProxy,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fillEqually) {
        self.init(
            height: height,
            buttonCreator: { AutocompleteToolbarLabel(text: $0, textDocumentProxy: textDocumentProxy) },
            alignment: alignment,
            distribution: distribution
        )
    }

    /**
     Create an autocomplete toolbar that has a custom button
     creation function.
     */
    public convenience init(
        height: CGFloat = .standardKeyboardRowHeight,
        buttonCreator: @escaping ButtonCreator,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fillEqually) {
        self.init(height: height, alignment: alignment, distribution: distribution)
        stackView.spacing = 0
        self.buttonCreator = buttonCreator
    }
    
    public typealias ButtonCreator = (String) -> (UIView)

    public var buttonCreator: ButtonCreator!
    
    private var suggestions: [String] = [] {
        didSet {
            if oldValue == suggestions { return }
            let buttons = suggestions.map { buttonCreator($0) }
            stackView.removeAllArrangedSubviews()
            stackView.addArrangedSubviews(buttons)
        }
    }
    
    public func reset() {
        update(with: [])
    }
    
    /**
     Update the toolbar with new words. This will remove all
     previously added views from the stack view and create a
     new set of views for the new word collection.
     */
    public func update(with suggestions: [String]) {
        self.suggestions = suggestions
    }
}
