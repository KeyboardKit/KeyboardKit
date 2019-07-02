//
//  AutoCompleteToolbar.swift
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

public class AutoCompleteToolbar: KeyboardToolbar {

    public convenience init(
        height: CGFloat,
        buttonCreator: @escaping ButtonCreator,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fillEqually) {
        self.init(height: height, alignment: alignment, distribution: distribution)
        self.buttonCreator = buttonCreator
        
    }
    
    public typealias ButtonCreator = (String) -> (UIView)

    public var buttonCreator: ButtonCreator!
    
    public func update(with words: [String]) {
        let buttons = words.map { buttonCreator($0) }
        stackView.removeAllArrangedSubviews()
        stackView.addArrangedSubviews(buttons)
    }
}
