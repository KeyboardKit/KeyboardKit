//
//  AutocompleteToolbarSeparator.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-12-09.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 This view is added as `AutocompleteToolbarLabel` separators
 to separate autocomplete labels in an `AutocompleteToolbar`.
 
 You can style the appearance of these separators, using the
 `AutocompleteToolbarSeparator.appearance` proxy.
 */
public class AutocompleteToolbarSeparator: UIView {
    
    public override func willMove(toWindow window: UIWindow?) {
        backgroundColor = .lightGray
        super.willMove(toWindow: window)
    }
}
