//
//  AutocompleteToolbarSeparator.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-12-09.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This class is added as`AutocompleteToolbarLabel` separators
 to separate autocomplete labels.
 
 The class has no logic of its own, but can be used to style
 these view, using `AutocompleteToolbarSeparator.appearance`.
 */
public class AutocompleteToolbarSeparator: UIView {
    
    public override func willMove(toWindow window: UIWindow?) {
        backgroundColor = .lightGray
        super.willMove(toWindow: window)
    }
}
