//
//  UIAutocompleteToolbarSeparator.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-12-09.
//  Copyright © 2021 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This view is added as `AutocompleteToolbarLabel` separators
 to separate autocomplete labels in an `AutocompleteToolbar`.
 */
public class UIAutocompleteToolbarSeparator: UIView {
    
    public override func willMove(toWindow window: UIWindow?) {
        backgroundColor = .lightGray
        super.willMove(toWindow: window)
    }
}
