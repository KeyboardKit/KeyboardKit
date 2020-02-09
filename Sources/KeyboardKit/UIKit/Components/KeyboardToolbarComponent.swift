//
//  KeyboardToolbarComponent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-20.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 Toolbar components are view components that can be added to
 the horizontal stack view of a toolbar.
 
 If a stack view uses another distribution than `fillEqually`,
 you must specify a width for each toolbar component.
 */
public protocol KeyboardToolbarComponent: HorizontalKeyboardComponent {}
