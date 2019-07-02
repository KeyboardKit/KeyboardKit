//
//  KeyboardAutocompleteToolbar.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-07-02.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 This toolbar can be used to present autocomplete suggestion
 words while the user types.
 
 */

import UIKit

public class KeyboardAutocompleteToolbar: KeyboardToolbar {

    public convenience init(
        height: CGFloat,
        words: [String],
        buttonCreator: ButtonCreator,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fillEqually) {
        self.init(height: height, alignment: alignment, distribution: distribution)
        let buttons = words.map { buttonCreator($0) }
        stackView.addArrangedSubviews(buttons)
    }
    
    public typealias ButtonCreator = (String) -> (UIView)

}
