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
 to the horizontal stack view of a keyboard button row.
 
 If a stack view uses another distribution than `fillEqually`,
 you must specify a width for each row component.
 */
public protocol KeyboardButtonRowComponent: HorizontalKeyboardComponent {}
