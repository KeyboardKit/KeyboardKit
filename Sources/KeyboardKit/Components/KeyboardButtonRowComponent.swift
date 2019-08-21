//
//  KeyboardButtonRowComponent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-04-28.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit


/**
 This protocol represents a view component that can be added
 to a keyboard button row's horizontal stack view.
 
 If the stack views use a different distribution method than
 `.fillEqually`, you must specify a width for each component.
 */
public protocol KeyboardButtonRowComponent: HorizontalKeyboardComponent {}
