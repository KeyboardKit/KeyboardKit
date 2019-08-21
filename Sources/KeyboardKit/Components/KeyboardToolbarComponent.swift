//
//  KeyboardToolbarComponent.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2019-05-20.
//  Copyright © 2019 Daniel Saidi. All rights reserved.
//

import UIKit

/**
 Toolbar components are views that can be added to toolbar's
 horizontal stack view.
 
 If the stack views use a different distribution method than
 `.fillEqually`, you must specify a width for each component.
 */
public protocol KeyboardToolbarComponent: HorizontalKeyboardComponent {}
