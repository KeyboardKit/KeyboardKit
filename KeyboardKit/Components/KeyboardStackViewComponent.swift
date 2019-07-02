//
//  KeyboardComponent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

/*
 
 Keyboard stack view components are "rows" that can be added
 to your `KeyboardInputViewController`'s `keyboardStackView`,
 e.g. toolbars, button rows, auto-complete components etc.
 
 */

import UIKit

public protocol KeyboardStackViewComponent: VerticalKeyboardComponent {}
